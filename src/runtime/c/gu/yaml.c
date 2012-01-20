#include <gu/yaml.h>
#include <gu/seq.h>
#include <gu/assert.h>
#include <gu/read.h>
#include <gu/ucs.h>
#include <stdio.h>
#include <stdarg.h>
#include <ctype.h>


const GuYamlAnchor gu_yaml_null_anchor = 0;

typedef const struct GuYamlState GuYamlState;

struct GuYamlState {
	const char* prefix;
	const char* suffix;
	GuYamlState* next;
};

static const struct {
	GuYamlState document, first_key, key, value, first_elem, elem;
} gu_yaml_states = {
	.document = {
		.prefix = "---\n",
		.suffix = "\n...\n",
		.next = &gu_yaml_states.document,
	},
	.key = {
		.prefix = "? ",
		.next = &gu_yaml_states.value,
	},
	.value = {
		.prefix = ": ",
		.suffix = ",",
		.next = &gu_yaml_states.key,
	},
	.elem = {
		.suffix = ",",
		.next = &gu_yaml_states.elem,
	},
};

typedef const struct GuYamlFrameClass GuYamlFrameClass;

struct GuYamlFrameClass {
	const char* open;
	GuYamlState* first;
	const char* close;
};

static const struct {
	GuYamlFrameClass document, mapping, sequence;
} gu_yaml_frame_classes = {
	.mapping = {
		.open = "{",
		.first = &gu_yaml_states.key,
		.close = "}",
	},
	.sequence = {
		.open = "[",
		.first = &gu_yaml_states.elem,
		.close = "]",
	},
};

typedef struct GuYamlFrame GuYamlFrame;

struct GuYamlFrame {
	GuYamlFrameClass* klass;
	GuYamlState* next;
};

typedef GuBuf GuYamlStack;

struct GuYaml {
	GuWriter* wtr;
	GuExn* err;
	GuPool* pool;
	GuYamlState* state;
	bool in_node;
	bool have_anchor;
	bool have_tag; 
	int next_anchor;
	bool indent;
	int indent_level;
	bool indented;
	GuYamlStack* stack;
};


GuYaml*
gu_new_yaml(GuWriter* wtr, GuExn* err, GuPool* pool)
{
	GuYaml* yaml = gu_new(GuYaml, pool);
	yaml->wtr = wtr;
	yaml->pool = pool;
	yaml->err = err;
	yaml->state = &gu_yaml_states.document;
	yaml->in_node = false;
	yaml->have_anchor = false;
	yaml->have_tag = false;
	yaml->next_anchor = 1;
	yaml->stack = gu_new_buf(GuYamlFrame, pool);
	yaml->indent = true;
	yaml->indent_level = 0;
	yaml->indented = false;
	return yaml;
}

static void
gu_yaml_printf(GuYaml* yaml, const char* fmt, ...)
{
	va_list args;
	va_start(args, fmt);
	gu_vprintf(fmt, args, yaml->wtr, yaml->err);
	va_end(args);
}

static void
gu_yaml_putc(GuYaml* yaml, char c)
{
	gu_putc(c, yaml->wtr, yaml->err);
}

static void
gu_yaml_puts(GuYaml* yaml, const char* str)
{
	gu_puts(str, yaml->wtr, yaml->err);
}

static void
gu_yaml_begin_line(GuYaml* yaml)
{
	if (yaml->indent && !yaml->indented) {
		for (int i = 0; i < yaml->indent_level; i++) {
			gu_yaml_putc(yaml, ' ');
		}
		yaml->indented = true;
	}
}

static void
gu_yaml_end_line(GuYaml* yaml)
{
	if (yaml->indent) {
		gu_yaml_putc(yaml, '\n');
	}
	yaml->indented = false;
}


static void 
gu_yaml_begin_node(GuYaml* yaml)
{
	gu_yaml_begin_line(yaml);
	if (!yaml->in_node) {
		if (yaml->state->prefix != NULL) {
			gu_yaml_puts(yaml, yaml->state->prefix);
		}
		yaml->in_node = true;
	}
}

static void
gu_yaml_end_node(GuYaml* yaml)
{
	gu_assert(yaml->in_node);
	if (yaml->state->suffix != NULL) {
		gu_yaml_puts(yaml, yaml->state->suffix);
	}
	gu_yaml_end_line(yaml);
	yaml->in_node = false;
	yaml->have_anchor = false;
	yaml->have_tag = false;
	if (yaml->state != NULL) {
		yaml->state = yaml->state->next;
	}
}

static void
gu_yaml_begin(GuYaml* yaml, GuYamlFrameClass* klass)
{
	gu_yaml_begin_node(yaml);
	gu_yaml_puts(yaml, klass->open);
	gu_buf_push(yaml->stack, GuYamlFrame,
		    ((GuYamlFrame) { .klass = klass, .next = yaml->state}));
	yaml->state = klass->first;
	yaml->in_node = yaml->have_anchor = yaml->have_tag = false;
	gu_yaml_end_line(yaml);
	yaml->indent_level++;
}

void
gu_yaml_begin_mapping(GuYaml* yaml)
{
	gu_yaml_begin(yaml, &gu_yaml_frame_classes.mapping);
}

void
gu_yaml_begin_sequence(GuYaml* yaml)
{
	gu_yaml_begin(yaml, &gu_yaml_frame_classes.sequence);
}

void 
gu_yaml_end(GuYaml* yaml)
{
	gu_assert(!yaml->in_node);
	yaml->indent_level--;
	gu_yaml_begin_line(yaml);
	GuYamlFrame f = gu_buf_pop(yaml->stack, GuYamlFrame);
	gu_yaml_puts(yaml, f.klass->close);
	yaml->state = f.next;
	yaml->in_node = true;
	gu_yaml_end_node(yaml);
}


void 
gu_yaml_scalar(GuYaml* yaml, GuString s)
{
	gu_yaml_begin_node(yaml);
	gu_yaml_putc(yaml, '"');
	GuPool* tmp_pool = gu_local_pool();
	GuReader* rdr = gu_string_reader(s, tmp_pool);
	GuExn* err = gu_exn(yaml->err, GuEOF, NULL);
	
	static const char esc[0x20] = {
		[0x00] = '0',
		[0x07] = 'a', 'b', 't', 'n', 'v', 'f', 'r',
		[0x1b] = 'e'
	};

	while (true) {
		GuUCS u = gu_read_ucs(rdr, err);
		if (!gu_ok(err)) {
			break;
		}
		if (GU_LIKELY(u >= 0x20 && u < 0x7f)) {
			if (GU_UNLIKELY(u == 0x22 || u == 0x5c)) {
				gu_yaml_putc(yaml, '\\');
			}
			gu_ucs_write(u, yaml->wtr, yaml->err);
		} else if (GU_UNLIKELY(u < 0x20 && esc[u])) {
			gu_yaml_printf(yaml, "\\%c", esc[u]);
		} else if (GU_UNLIKELY(u <= 0x9f)) {
			gu_yaml_printf(yaml, "\\x%02x", (unsigned) u);
		} else if (GU_UNLIKELY((u >= 0xd800 && u <= 0xdfff) ||
				       (u >= 0xfffe && u <= 0xffff))) {
			gu_yaml_printf(yaml, "\\u%04x", (unsigned) u);
		} else {
			gu_ucs_write(u, yaml->wtr, yaml->err);
		}
	}
	gu_pool_free(tmp_pool);
	gu_yaml_putc(yaml, '"');
	gu_yaml_end_node(yaml);
}

static void 
gu_yaml_tag(GuYaml* yaml, const char* format, ...)
{
	gu_yaml_begin_node(yaml);
	gu_assert(!yaml->have_tag);
	gu_yaml_putc(yaml, '!');
	va_list args;
	va_start(args, format);
	gu_vprintf(format, args, yaml->wtr, yaml->err);
	va_end(args);
	gu_yaml_putc(yaml, ' ');
	yaml->have_tag = true;
}

void 
gu_yaml_tag_primary(GuYaml* yaml, const char* tag) 
{
	// TODO: check tag validity
	gu_yaml_tag(yaml, "%s", tag);
}

void
gu_yaml_tag_secondary(GuYaml* yaml, const char* tag)
{
	// TODO: check tag validity
	gu_yaml_tag(yaml, "!%s", tag);
}

void
gu_yaml_tag_named(GuYaml* yaml, const char* handle, const char* tag)
{
	// TODO: check tag validity
	gu_yaml_tag(yaml, "%s!%s", handle, tag);
}

void
gu_yaml_tag_verbatim(GuYaml* yaml, const char* uri)
{
	// XXX: uri escaping?
	gu_yaml_tag(yaml, "<%s>", uri);
}

void
gu_yaml_tag_non_specific(GuYaml* yaml)
{
	gu_yaml_tag(yaml, "");
}

GuYamlAnchor
gu_yaml_anchor(GuYaml* yaml)
{
	gu_yaml_begin_node(yaml);
	gu_assert(!yaml->have_anchor);
	yaml->have_anchor = true;
	int anchor = yaml->next_anchor++;
	gu_yaml_printf(yaml, "&%d ", anchor);
	return anchor;
}

void
gu_yaml_alias(GuYaml* yaml, GuYamlAnchor anchor)
{
	gu_yaml_begin_node(yaml);
	gu_assert(!yaml->have_anchor && !yaml->have_tag);
	gu_yaml_printf(yaml, "*%d ", anchor);
	gu_yaml_end_node(yaml);
	return;
}

void gu_yaml_comment(GuYaml* yaml, GuString s)
{
	gu_yaml_begin_line(yaml);
	gu_yaml_puts(yaml, "# ");
	// TODO: verify no newlines in comment
	gu_string_write(s, yaml->wtr, yaml->err);
	gu_yaml_puts(yaml, "\n");
	yaml->indented = false;
}

