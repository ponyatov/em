module Format

let cf: unit =
    File.WriteAllText(
        ".clang-format",
        """BasedOnStyle: Google
IndentWidth:  4
TabWidth:     4
UseTab:       Never
ColumnLimit:  80
UseCRLF:      false

SortIncludes: false

AllowShortBlocksOnASingleLine: Always
AllowShortFunctionsOnASingleLine: All
"""
    )

let prettier: unit = File.WriteAllText(".prettierc", "")


let editorconfig: unit = File.WriteAllText(".editorconfig", "")

let format :unit = // 
    cf
    prettier
    editorconfig
