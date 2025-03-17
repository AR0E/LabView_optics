#import "../src/lib.typ": *

= How LabView operates

LabView is a graphical development environment, where one draws diagrams
representing certain state machines. Programs in LV are are directed functional 
graphs containing certain pre-packaged functionalities1;
these are all represented inb _.vi_ (Virtual Instrument) files, where each _VI_ 
represents a simple subroutine block. The content of the represented code is both
the graphical (diagrammatic) representation, and the eventual compiled information
(inplaceness information). One can also purposely separate the production of the two
starting from LV2010.


The compilation pipeline for _G (dataflow)_ code (not to be confused with CNC G-code), 
the language of the actual drawn diagrams,
involves a _type propagation alogithm_. All diagrams are converted to a high-level
FDIR graph languaage. This "sequent graph calculus" is useful since its more amenable
to particular machine-instruction rleated refinement steps not possible in G code.
The so-called "_DFIR decompositions_" would correspond to intuitive logical steps.


The type propagation checks the validity and optimizes the graph, 
as well as to then generate an intermediate sequent calculus 
representation to be handled by a LLVM compiler, producing machine code directly into an 
´.exe´.

== Actor Frameworks


= Interoperability with different languages

The basic way to operate on G NV code is by means of external DLLs
that are compatible with C, which is naturally interoperable wiyth G.
We'll consider two very different languages, _Rust_ and _Python_, altough
this is possible on virtually any language, including _OCaml_ and _Haskell_.

Rust is famous for its very good performance and intrinsic memory safety,
as well as having many pre-packaged functionalities and existing libraries.
Python, being a dynamically typed scripting language, is far slower
but easier to make more sophisticated programs. 

== Rust

For Rust, we need to produce a C-compatible DLL. This can be done
by explictly directing the compiled code into a `[lib]` package
in the `cargo.toml` file of any Rust project @cargo_targets.

#figure(
  ```rust
[package]
name = "demo_dll"
version = "0.1.0"
edition = "2021"

[dependencies]

[lib] // Library target settings
name = "demo_dll" 
rate-type = ["cdylib"] // Library for C/C++ integration
  ```,

  caption: "Basic _msnifest_ for a standard C compiled DLL." ,
)

By specifying `[cdylib]` we produce the necessary C ABI as
a dynamic library, DLL. In order to expose this functionality to other softwares, 
like LabView, all the relevant functions mut be _external functions_ @rust_linkage.
One can further specific dynamic runtime architecture, such as
with `[arm-unknown-linux-musleabi` and the like, altough LV automatically
does so in its internal compilation process.

When actually wrtiting down functions for LabView, use the
`#[no_mangle]` attreibute as well to facilitate linking,
as it forces the produced libraries to retain the precise
function names for calling.

#figure(
 ```rust
#[no_mangle] // Don't obfuscate function names

pub extern "C" fn add_numbers(a: i32, b: i32) -> i32 {
    return a + b;
}
```,

  caption: "A simple external function that adds and returns a `i32`." ,
)


When in LV, use the _*Call Library Function Node*_ and summon the produced DLL.
Carefully add the parameters with the proper typing in the _parameters_
menu; for example, if you selected a `i32` return type, guarantee you're using a 
32-bit signed integer.

== Python

LabView naturally comes with Python support; it contains three nodes,
an _Open/Close Python Session_ and _Python Call_ node. When placed sequentially,
one specifies the Python version and filepath for the programs in question, and then
one can call the functions quite easily.

