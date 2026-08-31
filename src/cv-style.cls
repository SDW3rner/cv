% -- Encoding UTF-8 without BOM

\ProvidesClass{cv-style}[2015/02/27 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{deutsch}{\def\@cv@deutsch{}}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}

%----------------------------------------------------------------------------------------
% Colors %
%----------------------------------------------------------------------------------------

\RequirePackage{xcolor}

\definecolor{white}{RGB}{255,255,255}

\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}

\definecolor{blue}{HTML}{66D9EE}
\definecolor{red}{HTML}{FA2772}
\definecolor{orange}{HTML}{FE9720}
\definecolor{green}{HTML}{A7E22E}
\definecolor{purple}{HTML}{9358FE}
\definecolor{aquamarine}{HTML}{36AF90}

\definecolor{date}{HTML}{A4A4A4}

\ifdefined\@cv@print
  \colorlet{blue}{gray}
  \colorlet{red}{gray}
  \colorlet{orange}{gray}
  \colorlet{green}{gray}
  \colorlet{purple}{gray}
  \colorlet{aquamarine}{gray}
  \colorlet{fillheader}{white}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
\fi
\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}

%----------------------------------------------------------------------------------------
% Fonts %
%----------------------------------------------------------------------------------------


\def\fontpath{fonts/}%

\RequirePackage[quiet]{fontspec}
\RequirePackage[math-style=TeX]{unicode-math}

\newfontfamily\bodyfont{Roboto-Regular}[Path=\fontpath]
\newfontfamily\bodyfontit{Roboto-LightItalic}[Path=\fontpath]
\newfontfamily\thinfont{Roboto-Thin}[Path=\fontpath]
\newfontfamily\headingfont{RobotoCondensed-Bold}[Path=\fontpath]

\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Mapping=tex-text, Color=textcolor, Path=\fontpath]{Roboto-Light}

\newcommand{\italica}[1]{%
    {\color{gray}\bodyfontit #1}%
}

%----------------------------------------------------------------------------------------
% Header %
%----------------------------------------------------------------------------------------

\RequirePackage{graphicx}
\RequirePackage{tikz}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=2.2cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box.center) {%
      \fontsize{40pt}{65pt}\color{header}%
      {\thinfont #1}\hspace{0.3cm}{\bodyfont #2}
    };
    \node [anchor=north, yshift=-0.55cm] (subtitle) at (box.center) {%
      \fontsize{11pt}{14pt}\color{header}%
      {\bodyfont #3}
    };
  \end{tikzpicture}
  \vspace{1.3cm}
  \vspace{-2\parskip}
}

%----------------------------------------------------------------------------------------
%	Last updated command %
%----------------------------------------------------------------------------------------

\RequirePackage[absolute,overlay]{textpos}

\newcommand{\sethyphenation}[3][]{%
  \ignorespaces
}
%\sethyphenation[<options>]{<language>}{<list of words separated by spaces>}

\makeatletter
\ifdefined\@cv@deutsch
  \def\lastupdatedtext{Zuletzt aktualisiert am}
\else
  \def\lastupdatedtext{Last Updated on}
\fi

\setlength{\TPHorizModule}{0.01\paperwidth}
\setlength{\TPVertModule}{0.01\paperwidth}

\newcommand{\lastupdated}{
  \begin{textblock}{10}(11.3, 0.05)
    \raggedleft
    \fontsize{8pt}{10pt}\color{white}\thinfont
    \lastupdatedtext{} \today
  \end{textblock}}

%----------------------------------------------------------------------------------------
% Structure %
%----------------------------------------------------------------------------------------
\RequirePackage{parskip}

\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{%
  {%
    \color{%
      \ifcase\value{colorCounter}%
        blue\or%
        red\or%
        orange\or%
        green\or%
        purple\or%
        aquamarine\else%
        headercolor\fi%
    } #1#2#3%
  }%
  \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
  {\par\vspace{0.2cm}
  {%
    \LARGE\headingfont\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{0.1cm}}
}

\renewcommand{\subsection}[2]{
  \par\vspace{.5\parskip}%
  \Large\headingfont\color{headercolor} #2%
  \par\vspace{.25\parskip}%
}

\newcommand{\jobtitle}[1]{%
    {\color{gray}\bodyfontit #1}%
}

\pagestyle{empty}

%----------------------------------------------------------------------------------------
% List environment %
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}
\newenvironment{entrylist}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\headingfont\color{headercolor}}
\newcommand{\skillentry}[2]{%
  \parbox[t]{15.2cm}{%
    \textbf{#1}
    \hfill
    {\footnotesize\addfontfeature{Color=lightgray} #2}\\%
    \vspace{-0.2cm}\vspace{\parsep}%
  }\\}
\newcommand{\entry}[3]{%
  #1&\parbox[t]{12.8cm}{%
    \textbf{#2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #3}\\%
    \vspace{-0.3cm}\vspace{\parsep}%
  }\\}
\newcommand{\entrywithlogo}[5]{%
  \parbox[t]{3.0cm}{%
    \raggedright #1\par\vspace{0.08cm}%
    \includegraphics[height=0.62cm, width=2.16cm,keepaspectratio]{#5}%
  }&\parbox[t]{12.8cm}{%
    \textbf{#2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #3}\\%
    #4\vspace{0.1cm}%
  }\\}
\newcommand{\entrywithlogos}[6]{%
  \parbox[t]{3.0cm}{%
    \raggedright #1\par\vspace{0.08cm}%
    \includegraphics[height=0.62cm, width=2.16cm,keepaspectratio]{#5}\\%
    \includegraphics[height=0.62cm, width=2.16cm,keepaspectratio]{#6}%
  }&\parbox[t]{12.8cm}{%
    \textbf{#2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #3}\\%
    #4\vspace{0.1cm}%
  }\\}

%----------------------------------------------------------------------------------------
% Side block %
%----------------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{aside}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \par\vspace{0.3cm}{\Large\headingfont\color{headercolor} ##1}
  }
  \begin{textblock}{3.6}(1, 2.57)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}

%----------------------------------------------------------------------------------------
% Other tweaks %
%----------------------------------------------------------------------------------------

\RequirePackage[left=5.1cm,top=0.7cm,right=0.5cm,bottom=0.6cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}
\hypersetup{
    pdftitle=CV/Resume \textbar{} Simon Denis Werner,
    pdfauthor=Simon Denis Werner,
    pdfsubject=CV/Resume%
    }
