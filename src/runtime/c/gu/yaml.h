#ifndef GU_YAML_H_
#define GU_YAML_H_

#include <gu/mem.h>
#include <gu/write.h>
#include <gu/string.h>

typedef struct GuYaml GuYaml;

typedef int GuYamlAnchor;

extern const GuYamlAnchor gu_yaml_null_anchor;

GuYaml* gu_new_yaml(GuWriter* wtr, GuExn* err, GuPool* pool);

GuYamlAnchor gu_yaml_anchor(GuYaml* yaml);

void gu_yaml_tag_primary(GuYaml* yaml, const char* tag);
void gu_yaml_tag_secondary(GuYaml* yaml, const char* tag);
void gu_yaml_tag_named(GuYaml* yaml, const char* handle, const char* tag);
void gu_yaml_tag_verbatim(GuYaml* yaml, const char* uri);
void gu_yaml_tag_non_specific(GuYaml* yaml);
void gu_yaml_comment(GuYaml* yaml, GuString comment);


void gu_yaml_scalar(GuYaml* yaml, GuString scalar);

void gu_yaml_alias(GuYaml* yaml, GuYamlAnchor anchor);

void gu_yaml_begin_document(GuYaml* yaml);

void gu_yaml_begin_sequence(GuYaml* yaml);

void gu_yaml_begin_mapping(GuYaml* yaml);

void gu_yaml_end(GuYaml* yaml);

#endif // GU_YAML_H_
