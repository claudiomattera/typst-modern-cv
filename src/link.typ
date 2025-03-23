// Copyright Claudio Mattera 2023-2025.
//
// Distributed under the MIT License.
// See accompanying file License.txt, or online at
// https://opensource.org/licenses/MIT

/// Draw a link with a label in current font
///
/// - url (str): The link URL.
/// - label (str): The link label.
/// -> content: The formatted link.
#let draw_link(url, label) = {
    link(url, label)
}

/// Draw a link to an URL (with an optional label) in monospace font
///
/// - url (str): The link URL.
/// - label (str): The link label (optional).
/// -> content: The formatted link.
#let draw_literal_link(url, label: "") = {
    let label = if label == "" {
        url
    } else {
        label
    }


    link(url, raw(label))
}
