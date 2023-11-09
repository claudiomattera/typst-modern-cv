// Copyright Claudio Mattera 2023.
//
// Distributed under the MIT License.
// See accompanying file License.txt, or online at
// https://opensource.org/licenses/MIT

#import "../src/lib.typ": configure_theme

#set document(
    title: "John Doe - Curriculum Vitæ",
    author: "John Doe",
)

#set page(
    paper: "a4",
    margin: (x: 1.5cm, y: 1.5cm),
)

#configure_theme(style: "underline")

#include "example.typ"
