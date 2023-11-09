// Copyright Claudio Mattera 2023.
//
// Distributed under the MIT License.
// See accompanying file License.txt, or online at
// https://opensource.org/licenses/MIT

/// Create a default theme configuration
///
/// -> dictionary: A dictionary with the default theme.
#let default() = {
    (
        color: blue,
        width: 2cm,
        thickness: 1.5mm,
        radius: 1pt,
        style: "underline",
        base_date: datetime(year: 2005, month: 1, day: 1),
        current_date: datetime.today(),
    )
}

#let state = state("timeline", default())

/// Update theme configuration
///
/// There are two supported styles: `underline` (default) and `lighten`.
/// `underline` shows timelines as coloured intervals above gray underlines, such as the original LaTeX package `moderntimeline`.
/// `lighten`, on the other hand, shows timelines as coloured intervals over full, lightened intervals.
///
/// Note: all arguments are optional, and their default value will be used if missing.
///
/// - color (color): The theme base color.
/// - width (length): The width of right bars and timelines.
/// - thickness (length): The thickness of right bars and timelines.
/// - radius (length): The radius of timelines.
/// - style (str): The theme style.
/// - base_date (datetime): The earliest date in all entries.
/// - current_date (datetime): The latest date in all entries.
/// -> dictionary: A dictionary with the default theme.
#let update(
    color: none,
    width: none,
    thickness: none,
    radius: none,
    style: none,
    base_date: none,
    current_date: none,
) = {
    state.display(state_value => {

        if color != none {
            state_value.color = color
        }

        if width != none {
            state_value.width = width
        }

        if thickness != none {
            state_value.thickness = thickness
        }

        if radius != none {
            state_value.radius = radius
        }

        if style != none {
            state_value.style = style
        }

        if base_date != none {
            state_value.base_date = base_date
        }

        if current_date != none {
            state_value.current_date = current_date
        }

        state.update(state_value)
    })
}
