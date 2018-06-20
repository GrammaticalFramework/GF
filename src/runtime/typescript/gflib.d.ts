/**
 * gflib.dt.s
 *
 * by John J. Camilleri
 *
 * TypeScript type definitions for the "original" JS GF runtime (GF:src/runtime/javascript/gflib.js)
 */

// Note: the String prototype is extended with:
// String.prototype.tag = "";
// String.prototype.setTag = function (tag) { this.tag = tag; };

/**
 * A GF grammar is one abstract and multiple concretes
 */
declare class GFGrammar {
  abstract: GFAbstract
  concretes: {[key: string]: GFConcrete}

  constructor(abstract: GFAbstract, concretes: {[key: string]: GFConcrete})

  translate(
    input: string,
    fromLang: string,
    toLang: string
  ): {[key: string]: {[key: string]: string}}
}

/**
 * Abstract Syntax Tree
 */
declare class Fun {
  name: string
  args: Fun[]

  constructor(name: string, ...args: Fun[])

  print(): string
  show(): string
  getArg(i: number): Fun
  setArg(i: number, c: Fun): void
  isMeta(): boolean
  isComplete(): boolean
  isLiteral(): boolean
  isString(): boolean
  isInt(): boolean
  isFloat(): boolean
  isEqual(obj: any): boolean
}

/**
 * Abstract syntax
 */
declare class GFAbstract {
  startcat: string
  types: {[key: string]: Type} // key is function name

  constructor(startcat: string, types: {[key: string]: Type})

  addType(fun: string, args: string[], cat: string): void
  getArgs(fun: string): string[]
  getCat(fun: string): string
  annotate(tree: Fun, type: string): Fun
  handleLiterals(tree: Fun, type: Type): Fun
  copyTree(x: Fun): Fun
  parseTree(str: string, type: string): Fun
  parseTree_(tokens: string[], prec: number): Fun
}

/**
 * Type
 */
declare class Type {
  args: string[]
  cat: string

  constructor(args: string[], cat: string)
}

type ApplyOrCoerce = Apply | Coerce

/**
 * Concrete syntax
 */
declare class GFConcrete {
  flags: {[key: string]: string}
  productions: {[key: number]: ApplyOrCoerce[]}
  functions: CncFun[]
  sequences: Array<Array<Sym>>
  startCats: {[key: string]: {s: number, e: number}}
  totalFIds: number
  pproductions: {[key: number]: ApplyOrCoerce[]}
  lproductions: {[key: string]: {fid: FId, fun: CncFun}}

  constructor(
    flags: {[key: string]: string},
    productions: {[key: number]: ApplyOrCoerce[]},
    functions: CncFun[],
    sequences: Array<Array<Sym>>,
    startCats: {[key: string]: {s: number, e: number}},
    totalFIds: number
  )

  linearizeSyms(tree: Fun, tag: string): Array<{fid: FId, table: any}>
  syms2toks(syms: Sym[]): string[]
  linearizeAll(tree: Fun): string[]
  linearize(tree: Fun): string
  tagAndLinearize(tree: Fun): string[]
  unlex(ts: string): string
  tagIt(obj: any, tag: string): any
  // showRules(): string // Uncaught TypeError: Cannot read property 'length' of undefined at gflib.js:451
  tokenize(string: string): string[]
  parseString(string: string, cat: string): Fun[]
  complete(
    input: string,
    cat: string
  ): {consumed: string[], suggestions: string[]}
}

/**
 * Function ID
 */
type FId = number

/**
 * Apply
 */
declare class Apply {
  id: string
  fun: FId
  args: PArg[]

  constructor(fun: FId, args: PArg[])

  show(cat: string): string
  isEqual(obj: any): boolean
}

/**
 * PArg
 */
declare class PArg {
  fid: FId
  hypos: any[]

  constructor(fid: FId, ...hypos: any[])
}

/**
 * Coerce
 */
declare class Coerce {
  id: string
  arg: FId

  constructor(arg: FId)

  show(cat: string): string
}

/**
 * Const
 */
declare class Const {
  id: string
  lit: Fun
  toks: any[]

  constructor(lit: Fun, toks: any[])

  show(cat: string): string
  isEqual(obj: any): boolean
}

/**
 * CncFun
 */
declare class CncFun {
  name: string
  lins: FId[]

  constructor(name: string, lins: FId[])
}

type Sym = SymCat | SymKS | SymKP | SymLit

/**
 * SymCat
 */
declare class SymCat {
  id: string
  i: number
  label: number

  constructor(i: number, label: number)

  getId(): string
  getArgNum(): number
  show(): string
}

/**
 * SymKS
 */
declare class SymKS {
  id: string
  tokens: string[]

  constructor(...tokens: string[])

  getId(): string
  show(): string
}

/**
 * SymKP
 */
declare class SymKP {
  id: string
  tokens: string[]
  alts: Alt[]

  constructor(tokens: string[], alts: Alt[])

  getId(): string
  show(): string
}

/**
 * Alt
 */
declare class Alt {
  tokens: string[]
  prefixes: string[]

  constructor(tokens: string[], prefixes: string[])
}

/**
 * SymLit
 */
declare class SymLit {
  id: string
  i: number
  label: number

  constructor(i: number, label: number)

  getId(): string
  show(): string
}

/**
 * Trie
 */
declare class Trie {
  value: any
  items: Trie[]

  insertChain(keys, obj): void
  insertChain1(keys, obj): void
  lookup(key, obj): any
  isEmpty(): boolean
}

/**
 * ParseState
 */
declare class ParseState {
  concrete: GFConcrete
  startCat: string
  items: Trie
  chart: Chart

  constructor(concrete: GFConcrete, startCat: string)

  next(token: string): boolean
  complete(correntToken: string): Trie
  extractTrees(): any[]
  process(
    agenda,
    literalCallback: (fid: FId) => any,
    tokenCallback: (tokens: string[], item: any) => any
  ): void
}

/**
 * Chart
 */
declare class Chart {
  active: any
  actives: {[key: number]: any}
  passive: any
  forest: {[key: number]: ApplyOrCoerce[]}
  nextId: number
  offset: number

  constructor(concrete: GFConcrete)

  lookupAC(fid: FId,label)
  lookupACo(offset, fid: FId, label)

  labelsAC(fid: FId)
  insertAC(fid: FId, label, items): void

  lookupPC(fid: FId, label, offset)
  insertPC(fid1: FId, label, offset, fid2: FId): void
  shift(): void
  expandForest(fid: FId): any[]
}

/**
 * ActiveItem
 */
declare class ActiveItem {
  offset: number
  dot: number
  fun: CncFun
  seq: Array<Sym>
  args: PArg[]
  fid: FId
  lbl: number

  constructor(
    offset: number,
    dot: number,
    fun: CncFun,
    seq: Array<Sym>,
    args: PArg[],
    fid: FId,
    lbl: number
  )

  isEqual(obj: any): boolean
  shiftOverArg(i: number, fid: FId): ActiveItem
  shiftOverTokn(): ActiveItem
}
