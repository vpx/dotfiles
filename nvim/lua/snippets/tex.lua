local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

ls.add_snippets("tex", {

  -- Sections
  s("sec", { t("\\section{"), i(1), t("}") }),
  s("subsec", { t("\\subsection{"), i(1), t("}") }),
  s("subsubsec", { t("\\subsubsection{"), i(1), t("}") }),

  -- Math
  s("im", { t("\\("), i(1), t("\\)") }),      -- inline math

  s("mm", {
    t({"\\[", ""}),  -- start display math and newline
    i(1),            -- cursor goes here
    t({"", "\\]"})   -- newline then closing
  }),

  s("eq", {
    t({"\\begin{equation}", ""}),
    i(1),
    t({"", "\\end{equation}"})
  }),

  s("align", {
    t({"\\begin{align}", ""}),
    i(1),
    t({"", "\\end{align}"})
  }),

  -- Lists
  s("itemize", {
    t({"\\begin{itemize}", "\t"}),
    i(1),
    t({"", "\\end{itemize}"})
  }),

  s("enumerate", {
    t({"\\begin{enumerate}", "\t"}),
    i(1),
    t({"", "\\end{enumerate}"})
  }),

  -- Figures
  s("fig", {
    t({"\\begin{figure}[h]", "\t\\centering", "\t\\includegraphics[width=\\textwidth]{"}),
    i(1),
    t({" }", "\t\\caption{"}),
    i(2),
    t({" }", "\t\\label{fig:"}),
    i(3),
    t({"", "\\end{figure}"})
  }),

  -- Tables
  s("tab", {
    t({"\\begin{table}[h]", "\t\\centering", "\t\\begin{tabular}{"}),
    i(1, "c|c"),
    t({" }", "\t"}),
    i(2),
    t({"", "\t\\end{tabular}", "\t\\caption{"}),
    i(3),
    t({" }", "\t\\label{tab:"}),
    i(4),
    t({"", "\\end{table}"})
  }),

  -- References / Citations
  s("cite", { t("\\cite{"), i(1), t("}") }),
  s("ref", { t("\\ref{"), i(1), t("}") }),
  s("eqref", { t("\\eqref{"), i(1), t("}") }),

  -- Document skeleton
  s("doc", {
    t({"\\documentclass{article}", "\\usepackage[utf8]{inputenc}", "\\usepackage{amsmath}", "\\usepackage{graphicx}", "\\begin{document}", ""}),
    i(1),
    t({"", "\\end{document}"})
  }),

  -- Generic environment with mirrored \begin/\end
  s("begin", {
    t({"\\begin{"}),
    i(1, "environment"), -- environment name
    t({"}", ""}),         -- newline after begin
    i(2),                 -- cursor inside environment
    t({"", "\\end{"}),
    rep(1),               -- repeats environment name
    t("}")
  }),
})

