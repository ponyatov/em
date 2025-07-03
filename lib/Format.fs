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

let prettier: unit = //
    File.WriteAllText(
        ".prettierc",
        """{
    "tabWidth"    : 4,
    "useTabs"     : false,
    "endOfLine"   : "lf",
    "singleQuote" : true,
    "semi"        : true,
    "printWidth"  : 80
}
"""
    )

let editorconfig: unit = //
    File.WriteAllText(
        ".editorconfig",
        """# fantomas config
indent_size = 4
max_line_length = 80
end_of_line = lf
insert_final_newline = true
"""
    )

let format: unit = //
    cf
    prettier
    editorconfig
