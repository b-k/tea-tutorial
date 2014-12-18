m4_divert(-1)
m4_changecom()
m4_changequote(`<|', `|>')

m4_define(<|define_blind|>, <|_define_blind(<|$1|>, <|$2|>, <|$|><|#|>, <|$|><|0|>)|>)
m4_define(<|_define_blind|>, <|m4_define(<|$1|>, <|m4_ifelse(<|$3|>, <|0|>, <|<|$4|>|>, <|$2|>)|>)|>)

define_blind(mm, <|<|$|>$*$|>)
define_blind(tt, <|\verb@$*@|>)
define_blind(Tt, <|{\tt $*}|>)
define_blind(sc, <|{\sc $*}|>)
define_blind(bf, <|{\bf $*}|>)
define_blind(em, <|{\em $*}|>)

define_blind(Citet, <|\citet{$1}|>)
define_blind(Citep, <|\citep<||>m4_ifelse($2,<||>,<||>,<|[$2]|>){$1}|>)

define_blind(TitleDate, <|\titledate{$1}{$2}|>)
define_blind(TeX, <|$*|>)
define_blind(HTML, <||>)
define_blind(Comment, <||>)
define_blind(Digression, <|\digression{$*}|>)
define_blind(Block, <|\begin{quote}$*\end{quote}|>)
define_blind(Verbatim, <|\begin{verbatim}
$*
\end{verbatim}|>)


define_blind(Pic, <|\begin{figure}[htb]
    \begin{center}
    \begin{tabular}{cc}
    \rotatebox{90}{\abox{$2}{../asst/$1}}
    \end{tabular}

    \caption{$3}
    \label{m4_patsubst($1, <|\..*|>, <||>)}
    \end{center}
\end{figure}
|>)

After converting from book format to article format, I downgraded
the first three section types [chapter -> section; section->subsection...]
define_blind(Chapter, <|\section{$*}|>)
define_blind(Section, <|\subsection{$*}|>)
define_blind(Subsection, <|\subsubsection{$*}|>)
define_blind(Paragraph, <|\paragraph{$*}|>)
define_blind(Link, <|\link{m4_shift($*)}{$1}|>)

define_ref(Ref, <|$1 (page \pageref{m4_translit(<|$2|>, ' 	
')})|>)

define_blind(N2D, <|\paragraph{$1}\label{m4_translit(<|$2|>, ' 	
')}\leavevmode\\

Narrative: $3

Distribution: $4

m4_ifelse(<|$5|>, <||>,,<|Notes: $5|>)

|>)

define_blind(Items,
<|\begin{itemize}
\setlength{\itemsep}{0pt}
\setlength{\parskip}{0pt}
\setlength{\parsep}{0pt}
m4_patsubst(<|$@|>, <|∙|>, <|\\item |>)\end{itemize}|>)

m4_divert(0)
