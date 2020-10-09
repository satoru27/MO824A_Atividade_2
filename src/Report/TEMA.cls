%%% ====================================================
%%% @LaTeX-file{
%%%    filename  = "TEMA.cls",
%%%    date      = "09/10/2010",
%%%    author    = "A. Sri Ranga",
%%%    abstract  = "This is a LaTeX documentclass for volumes of TEMA.",
%%% }
%%% ====================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{TEMA}

\LoadClass[10pt, a4paper, twoside]{article}
\setlength{\textwidth}{12.7cm}
\setlength{\textheight}{19.0cm}
\setlength{\topmargin}{0cm}
\setlength{\oddsidemargin}{1.61cm}
\setlength{\evensidemargin}{1.61cm}

\renewcommand{\encodingdefault}{T1}

%\renewcommand{\thefootnote}(\arabic{footnote}}

%\renewcommand{\thetheorem}{\arabic{section}.\arabic{theorem}.}
%\renewcommand{\thecor}{\arabic{section}.\arabic{cor}.}
%\renewcommand{\thelemma}{\arabic{section}.\arabic{lemma}.}

%\renewcommand{\thesection}{\arabic{section}.}
%\renewcommand{\thesubsection}{\arabic{section}.\arabic{subsection}.}
%\renewcommand{\thesubsubsection}{\arabic{section}.\arabic{subsection}.\arabic{subsubsection}.}
\renewcommand{\theequation}{\thesection.\arabic{equation}}

\usepackage{amsthm}
\usepackage{titlesec}

\titleformat{\section}
            {\normalfont\Large\bfseries}
            {\thesection.\setcounter{equation}{0} 
                                \setcounter{thmTEMA}{0}
                                \setcounter{teoTEMA}{0}
                                \setcounter{lemmaTEMA}{0}
                                \setcounter{lemaTEMA}{0} 
                                \setcounter{defTEMAi}{0}
                                \setcounter{defTEMAp}{0} 
                                \setcounter{propTEMAi}{0}
                                \setcounter{propTEMAp}{0}
                                }{-20mm}{}

\titleformat{\subsection}
            {\normalfont\large\bfseries}{\thesubsection.}{2mm}{}
\titleformat{\subsubsection}
            {\normalfont\normalsize\bfseries}{\thesubsubsection.}{1mm}{}


%\newcommand{\newsec}[1]{\section{#1}\setcounter{equation}{0} }
\newcommand{\newsec}[1]{\section{#1}\setcounter{equation}{0} 
                                    \setcounter{thmTEMA}{0}
                                    \setcounter{teoTEMA}{0}
                                    \setcounter{lemmaTEMA}{0}
                                    \setcounter{lemaTEMA}{0} 
                                    \setcounter{defTEMAi}{0}
                                    \setcounter{defTEMAp}{0} 
                                    \setcounter{propTEMAi}{0}
                                    \setcounter{propTEMAp}{0} } 
                     
                     
                                    

\newtheorem{thmTEMA}{Theorem}
\renewcommand{\thethmTEMA}{\arabic{section}.\arabic{thmTEMA}}
\newtheorem{teoTEMA}{Teorema}
\renewcommand{\theteoTEMA}{\arabic{section}.\arabic{teoTEMA}}

\newtheorem{lemmaTEMA}{Lemma}
\renewcommand{\thelemmaTEMA}{\arabic{section}.\arabic{lemmaTEMA}}
\newtheorem{lemaTEMA}{Lema}
\renewcommand{\thelemaTEMA}{\arabic{section}.\arabic{lemaTEMA}}

\newtheorem{propTEMAi}{Proposition}
\renewcommand{\thepropTEMAi}{\arabic{section}.\arabic{propTEMAi}}
\newtheorem{propTEMAp}{Proposi\c{c}\~{a}o}
\renewcommand{\thepropTEMAp}{\arabic{section}.\arabic{propTEMAp}}


\newtheorem{defTEMAi}{Definition}
\renewcommand{\thedefTEMAi}{\arabic{section}.\arabic{defTEMAi}}
\newtheorem{defTEMAp}{Defini\c{c}\~{a}o}
\newtheorem{remTEMAp}{Observa\c{c}\~{a}o}
\renewcommand{\thedefTEMAp}{\arabic{section}.\arabic{defTEMAp}}

\newtheorem{coroTEMAi}{Corollary}
%\renewcommand{\thecoroTEMAi}{\arabic{section}.\arabic{thmTEMA}.\arabic{coroTEMAi}}
\renewcommand{\thecoroTEMAi}{\arabic{section}.\arabic{thmTEMA}}
\newtheorem{coroTEMAp}{Corol\'ario}
%\renewcommand{\thecoroTEMAp}{\theteoTEMA}
\renewcommand{\thecoroTEMAp}{\arabic{section}.\arabic{teoTEMA}.\arabic{coroTEMAp}}
%\renewcommand{\thecoroTEMAp}{\arabic{section}.\arabic{teoTEMA}}


\renewenvironment{abstract}
{\begin{list}{}{%
  \setlength{\rightmargin}{0.5cm}
  \setlength{\leftmargin}{0.5cm}
  \small} 
  \item[] }
{\end{list}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\ps@headCNMAC}
{ \renewcommand{\@oddhead}
  {\begin{minipage}{\textwidth}
%HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
     {\normalsize {\bf Submetido para MO824}}\\
     {\normalsize {\em }} \\
%HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
     \rule{\textwidth}{0.6pt} 
   \end{minipage}
  }
%  \renewcommand{\@oddfoot}
%  {\begin{center}
%     \arabic{page}
%   \end{center}
%  }
  \renewcommand{\@oddfoot}{}
  \renewcommand{\@evenhead}{\@oddhead}
  \renewcommand{\@evenfoot}{\@oddfoot}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\criartitulo{\par
  \begingroup
    \renewcommand\thefootnote{\@arabic\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
      
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@criartitulo

    \thispagestyle{headCNMAC}\@thanks
    \markright{\bf \small \copyright \ SBMAC \\ TEMA  }
  \endgroup
  %\setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\criartitulo\relax
  \global\let\@criartitulo\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@criartitulo{%
  \newpage
  \null
  \vskip 0em%
  \begin{center}%
  \let \footnote \thanks
    {\LARGE \@title \par}%
  \end{center}%
    \vskip 1.5em%
    {\normalsize
      \lineskip .5em%
      \begin{minipage}[b]{\textwidth}
        \@author
      \end{minipage}\par}%
    \vskip 1em%
    %{\large \@date}%
  \par
  \vskip 1em}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%\pagestyle{myheadings}
\newcommand{\runningheads}{\markboth}
\pagestyle{myheadings}

\normalsize

\setcounter{page}{1}

\endinput
