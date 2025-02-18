#import "../src/lib.typ": *

#show: xyznote.with(
  title: "LabView Notes",
  author: "Artur R. B. Boyago",

  abstract: "Notes on LabView applications and integrations thereof. Hopefully using NI
  equipment won't be terribly difficult.",

  createtime: "2024-11-27",
  lang: "en",
  bibliography-style: "ieee",
  preface: [], 
  bibliography-file: bibliography("refs.bib"),
)

#include "ch1_structure.typ"
#include "ch2_rustintegration.typ"

