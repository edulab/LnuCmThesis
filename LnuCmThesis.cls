%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Linneaus University, Department of Computer Science and Media Technology
%%
%%  LnuCmThesis 
%%  Class File
%%  Version 1.0 (2019-05-10)
%%
%%  License
%%  =======
%%
%%  This work may be distributed and/or modified under the conditions of
%%  the LaTeX Project Public License, either version 1.3 of this license
%%  or (at your option) any later version. The latest version of this
%%  license is in:
%%
%%      http://www.latex-project.org/lppl.txt
%%
%%  and version 1.3 or later is part of all distributions of LaTeX version
%%  2005/12/01 or later.
%%
%%  Contributors
%%  ============
%%
%%  Mats Loock <mats.loock@lnu.se> (2019)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%   Class options
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{LnuCmThesis}[2019-05-07]

\RequirePackage{etoolbox}
\RequirePackage{xparse}
\providecommand{\imagespath}{{Images/}{./}}
\newbool{frontmattersintoc}
\newbool{abstractintoc}
\newbool{acknowledgementsintoc}
\newbool{listsintoc}
\newbool{tocintoc}
\newbool{twoside}
\newbool{leftblank}

\DeclareOption{frontmattersintoc}{\booltrue{frontmattersintoc}}
\DeclareOption{abstractintoc}{\booltrue{abstractintoc}}
\DeclareOption{acknowledgementsintoc}{\booltrue{acknowledgementsintoc}}
\DeclareOption{listsintoc}{\booltrue{listsintoc}}
\DeclareOption{tocintoc}{\booltrue{tocintoc}}
\DeclareOption{twoside}{\booltrue{twoside}}
\DeclareOption{leftblank}{\booltrue{leftblank}}

\ifbool{twoside}{
  \PassOptionsToClass{twoside}{book}
}{
  \PassOptionsToClass{oneside}{book}
}

\PassOptionsToClass{11pt}{book}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

\ProcessOptions
\LoadClass{book}

\AtBeginDocument{\raggedright}
\AtBeginDocument{\raggedbottom}

%----------------------------------------------------------------------------------------
%	Add contents lines to the table of contents
%----------------------------------------------------------------------------------------

\ifbool{frontmattersintoc}{
  \booltrue{abstractintoc}
  \booltrue{acknowledgementsintoc}
  \booltrue{listsintoc}
  \booltrue{tocintoc}
}{}

% If the listsintoc option has been passed to the class, add the lists to the table of contents.
\ifbool{listsintoc}{%
  \patchcmd{\listoftables}{\@starttoc{lot}}{%
    \addcontentsline{toc}{chapter}{\listtablename}\@starttoc{lot}}{}{}%
  \patchcmd{\listoffigures}{\@starttoc{lof}}{%
    \addcontentsline{toc}{chapter}{\listfigurename}\@starttoc{lof}}{}{}%
  % NOTE: List of listings is added in \renewcommand\lstlistoflistings
}{}

% If the tocintoc option has been passed to the class, add the table of contents to the table of contents.
\ifbool{tocintoc}{%
  \patchcmd{\tableofcontents}{\@starttoc{toc}}{%
    \addcontentsline{toc}{chapter}{\contentsname}\@starttoc{toc}}{}{}%
}{}

%----------------------------------------------------------------------------------------
%	Required packages
%----------------------------------------------------------------------------------------

\RequirePackage[utf8]{inputenc}    % Required to accept different input encodings.
\RequirePackage[T1]{fontenc}       % Required to be able to selecting font encodings.
\RequirePackage{times}
\RequirePackage{babel}             % Required  for multilingual support.
\RequirePackage{scrbase}           % Required for handling language-dependent names of elements.
\RequirePackage{scrextend}
\RequirePackage{graphicx}          % Required to include images.
\graphicspath{\imagespath}         % Specifies where to look for included images.
\RequirePackage{tikz}              % Required to position images.
\RequirePackage[absolute]{textpos} % Required to position text.
\RequirePackage{mdframed}          % Required for framed environments.
\RequirePackage{xcolor}
\RequirePackage[parfill]{parskip}
\RequirePackage{titlesec}
\RequirePackage[style=ieee]{biblatex}
\RequirePackage{csquotes}
\RequirePackage{lipsum}
\RequirePackage{blindtext}

%----------------------------------------------------------------------------------------
%   Define thesis information commands
%----------------------------------------------------------------------------------------

\newcommand*{\documenttype}[1]{\gdef\documenttypename{#1}}
\newcommand*{\documenttypename}{\textcolor{red}{\texttt{\textbackslash documenttype}}}

\title{\textcolor{red}{\texttt{\textbackslash title}}}

\newcommand*{\subtitle}[1]{\gdef\subtitlename{#1}}
\newcommand*{\subtitlename}{\textcolor{red}{\texttt{\textbackslash subtitle}}}

\author{\textcolor{red}{\texttt{\textbackslash author}}}

\newcommand*{\supervisor}[1]{\gdef\supervisorname{#1}}
\newcommand*{\supervisorname}{\textcolor{red}{\texttt{\textbackslash supervisor}}}

\newcommand*{\examiner}[1]{\gdef\examinername{#1}}
\newcommand*{\examinername}{\textcolor{red}{\texttt{\textbackslash examiner}}}

\newcommand*{\semester}[1]{\gdef\semestername{#1}}
\newcommand*{\semestername}{\textcolor{red}{\texttt{\textbackslash semester}}}

\newcommand*{\subject}[1]{\gdef\subjectname{#1}}
\newcommand*{\subjectname}{\textcolor{red}{\texttt{\textbackslash subject}}}

\newcommand*{\level}[1]{\gdef\levelname{#1}}
\newcommand*{\levelname}{\textcolor{red}{\texttt{\textbackslash level}}}

\newcommand*{\coursecode}[1]{\gdef\coursecodename{#1}}
\newcommand*{\coursecodename}{\textcolor{red}{\texttt{\textbackslash coursecode}}}

\newcommand*{\credits}[1]{\gdef\creditsname{#1}}
\newcommand*{\creditsname}{\textcolor{red}{\texttt{\textbackslash credits}}}

%----------------------------------------------------------------------------------------
%	Blank page message
%----------------------------------------------------------------------------------------

\newcommand*{\leftblankname}{}
\renewcommand*\leftblankname{(THIS PAGE INTENTIONALLY LEFT BLANK - DEFAULT)}
\addto{\captionsenglish}{%
  \renewcommand*\leftblankname{(THIS PAGE INTENTIONALLY LEFT BLANK)}}
\addto{\captionsswedish}{%
  \renewcommand*\leftblankname{(DENNA SIDA HAR LÄMNATS TOM MED AVSIKT)}}

\renewcommand{\cleardoublepage}{\clearpage\if@twoside%
    \ifodd\c@page\else
      \vspace*{\fill}
      \ifbool{leftblank}{%
        \hfill
        \begin{center}
          \leftblankname
        \end{center}
        \vspace{\fill}}{}
      \thispagestyle{empty}
      \newpage
      \if@twocolumn\hbox{}\newpage\fi\fi\fi
}

%----------------------------------------------------------------------------------------
%	Margins
%----------------------------------------------------------------------------------------

\RequirePackage{geometry}
\geometry{
  paper=a4paper,
  left=4cm,
  right=4cm,
  top=3cm,
  bottom=3cm,
  footskip=2cm,
  marginparwidth=3cm,
  headsep=1cm,
  headheight=1cm,
  %	showframe, % Uncomment to show how the type block is set on the page
}

%----------------------------------------------------------------------------------------
%	Background (all pages)
%----------------------------------------------------------------------------------------

\RequirePackage{background}

\backgroundsetup{
  scale=1,
  angle=0,
  opacity=1,
  color=black,
  contents={\begin{tikzpicture}[remember picture, overlay]
        \node[anchor=north west,
          xshift=1cm,
          yshift=-1cm,
          inner sep=0pt]
        at (current page.north west)
        {\includegraphics[height=1cm]{images/lnu_symbol_cmyk.eps}};
        % LNU wordmark
        \iflanguage{swedish}{
          \node[anchor=north west,xshift=4cm,yshift=-1cm,inner sep=0pt] at (current page.north west)
          {\includegraphics[height=1cm,keepaspectratio]{images/lnu_wordmark_kalmar_vaxjo_cmyk.eps}};
        }{
          \node[anchor=north west,xshift=4cm,yshift=-1cm,inner sep=0pt] at (current page.north west)
          {\includegraphics[height=1cm,keepaspectratio]{images/lnu_wordmark_sweden_eng_cmyk.eps}};
        }
      \end{tikzpicture}}
}

%----------------------------------------------------------------------------------------
%	Headers and footers
%----------------------------------------------------------------------------------------

\RequirePackage{fancyhdr}

\pagestyle{fancyplain}
\fancyhf{} % Clear header and footer.
\renewcommand{\headrulewidth}{0pt} % Hide the head rule.
\fancyfoot[C]{\thepage} % Center page number.

%----------------------------------------------------------------------------------------
%	Footnotes
%----------------------------------------------------------------------------------------

\deffootnote[1em]{2em}{0em}{\textsuperscript{\thefootnotemark}\,}

%----------------------------------------------------------------------------------------
%	Headings
%----------------------------------------------------------------------------------------

% Remove spaces above and below chapter/chapter* header and make it an one line header.
\DeclareDocumentCommand{\@makechapterhead}{m}{%
  {\parindent \z@ \raggedright \normalfont
      \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter
          \Huge\bfseries \thechapter\hspace{0.5em}
        \fi
      \fi
      \interlinepenalty\@M
      \Huge \bfseries #1\par\nobreak}}
\def\@makeschapterhead#1{%
  {\parindent \z@ \raggedright
      \normalfont
      \interlinepenalty\@M
      \Huge \bfseries  #1\par\nobreak}}

% Reduce horizontal space between section title and numbering (1em default).
\titleformat{\section}{\normalfont\Large\bfseries}{\thesection}{0.5em}{}
\titleformat{\subsection}{\normalfont\large\bfseries}{\thesubsection}{0.5em}{}
\titleformat{\subsubsection}{\normalfont\normalsize\bfseries}{\thesubsubsection}{0.5em}{}
\titleformat{\paragraph}{\normalfont\normalsize\itshape}{\theparagraph}{0.5em}{}

% Remove spaces above and below section/subsection/subsubsection.
\titlespacing*{\section}{0pt}{12pt plus 2pt minus 2pt}{0pt}
\titlespacing*{\subsection}{0pt}{12pt plus 2pt minus 2pt}{0pt}
\titlespacing*{\subsubsection}{0pt}{12pt plus 2pt minus 2pt}{0pt}
\titlespacing*{\paragraph}{0pt}{12pt plus 2pt minus 2pt}{0pt}

%----------------------------------------------------------------------------------------
%	Captions
%----------------------------------------------------------------------------------------

\RequirePackage{caption}

\DeclareCaptionLabelFormat{lf-default}{\textsc{#1} #2}

\captionsetup{
  font=footnotesize, % 9pt when \normalsize is 11pt
  format=hang,
  labelfont=bf,
  labelformat=simple,
  justification=RaggedRight,
  singlelinecheck=false,
  labelformat=lf-default,
  aboveskip=\smallskipamount,
  belowskip=-1.0\smallskipamount,
}

%\setlength{\intextsep}{0.5\baselineskip} % remove extra space above and below in-line float

%----------------------------------------------------------------------------------------
%	Listings
%----------------------------------------------------------------------------------------

\RequirePackage{listings}
\RequirePackage{courier}

\renewcommand*\lstlistlistingname{List of Listings}
\renewcommand*\lstlistingname{Listing}
\addto{\captionsenglish}{%
  \renewcommand*{\lstlistlistingname}{List of Listings}
  \renewcommand*\lstlistingname{Listing}}
\addto{\captionsswedish}{%
  \renewcommand*{\lstlistlistingname}{Programlistningar}
  \renewcommand*\lstlistingname{Programlistning}}

\definecolor{background}{rgb}{0.97,0.97,1.0}
\definecolor{codecomment}{HTML}{008000}
\definecolor{codekeyword}{HTML}{AF00DB}
\definecolor{codestring}{HTML}{B74747}
\definecolor{linenumber}{HTML}{A9A9A9}

\lstdefinestyle{defaultstyle}{
  basicstyle=\footnotesize\ttfamily,   % Default font
  %backgroundcolor=\color{background},   
  commentstyle=\color{codecomment},
  keywordstyle=\color{codekeyword},
  numberstyle=\tiny\color{linenumber},
  stringstyle=\color{codestring},
  breakatwhitespace=false,
  breaklines=true,                     % Lines will be wrapped
  captionpos=t,
  extendedchars=true,
  frame=bt,
  keepspaces=true,
  %numbers=left,                        % Location of line numbers
  numbersep=5pt,                       % Margin between line numbers and text
  numberstyle=\tiny\color{linenumber}, % Style of line numbers
  showspaces=false,
  showtabs=false,
  showstringspaces=false,
  tabsize=2,                           % Size of tabs
  xleftmargin=0pt,
}

\lstset{style=defaultstyle}

% \lstloadlanguages{} % default programming language

%\makeatletter
\renewcommand\lstlistoflistings{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{\lstlistlistingname}%
  \ifbool{listsintoc}{%
    \addcontentsline{toc}{chapter}{\lstlistlistingname}
  }{}
  \@mkboth{\MakeUppercase\contentsname}%
  {\MakeUppercase\contentsname}%
  \vspace{1em}
  \@starttoc{lol}%
  \if@restonecol\twocolumn\fi
}
%\makeatother

%----------------------------------------------------------------------------------------
%	Watermark
%----------------------------------------------------------------------------------------

\NewDocumentCommand\watermark{O{DRAFT}}{
  \RequirePackage[printwatermark]{xwatermark}
  \newsavebox\mybox
  \savebox\mybox{\tikz[color=red,opacity=0.3]\node{\sffamily#1};}
  \newwatermark*[
    allpages,
    angle=45,
    scale=6,
    xpos=-20,
    ypos=15
  ]{\usebox\mybox}
}

%----------------------------------------------------------------------------------------
%	Title page
%----------------------------------------------------------------------------------------

\newcommand{\authorlabel}{Author}
\providecaptionname{swedish}{\authorlabel}{Författare}
\newcommand{\supervisorlabel}{Supervisor}
\providecaptionname{swedish}{\supervisorlabel}{Handledare}
\newcommand{\examinerlabel}{Examiner}
\providecaptionname{swedish}{\examinerlabel}{Examinator}
\newcommand{\semesterlabel}{Semester}
\providecaptionname{swedish}{\semesterlabel}{Termin}
\newcommand{\subjectlabel}{Subject}
\providecaptionname{swedish}{\subjectlabel}{Ämne}
\newcommand{\levellabel}{Level}
\providecaptionname{swedish}{\levellabel}{Nivå}
\newcommand{\coursecodelabel}{Course code}
\providecaptionname{swedish}{\coursecodelabel}{Kurskod}
\newcommand{\creditslabel}{credits}
\providecaptionname{swedish}{\creditslabel}{hp}

% Define a mdframed environment (border left).
\newmdenv[
  topline=false,
  rightline=false,
  bottomline=false,
  linewidth=0.5pt,
  innerleftmargin=0.2cm,
  innertopmargin=0cm,
  innerbottommargin=0cm,
  skipabove=0cm,
  skipbelow=0cm
]{borderleft}

\renewcommand{\maketitle}{\begin{titlepage}
    %\newpage
    \null

    \begin{tikzpicture}[remember picture, overlay]
      % LNU copperplate
      \node[anchor=north west,xshift=-3.98cm,yshift=-15.6cm,inner sep=0pt] at (current page.north west)
      {\includegraphics[width=15.05cm,keepaspectratio]{images/lnu_copperplate.png}};
    \end{tikzpicture}

    % Document type (page left margin 4 cm, space between left border and text 0.2 cm -> 3.8 cm)
    \begin{textblock*}{13cm}[0,0](3.8cm,1cm)
      \begin{borderleft}
        \vbox to 5cm {
            \vfil
            \normalfont\fontsize{22pt}{29pt}\selectfont
            \documenttypename
          }
      \end{borderleft}
    \end{textblock*}

    % Title and subtitle
    \begin{textblock*}{13cm}[0,0](4cm,6cm)
      \vspace{72pt}
      \normalfont\fontsize{30pt}{36pt}\selectfont
      \@title\\
      \normalfont\fontsize{18pt}{22pt}\itshape\selectfont
      \subtitlename
    \end{textblock*}

    % Author, supervisor, examiner, etc.
    \begin{textblock*}{7.94cm}[0,1](12.62cm,29cm)
      \begin{borderleft}
        \normalfont
        \emph{\authorlabel:} \@author\\
        \emph{\supervisorlabel:} \supervisorname\\
        \emph{\examinerlabel:} \examinername\\
        \emph{\semesterlabel:} \semestername\\
        \emph{\subjectlabel:} \subjectname\\
        \emph{\levellabel:} \levelname\\
        \emph{\coursecodelabel:} \coursecodename, \creditsname\ \creditslabel
      \end{borderleft}
    \end{textblock*}

  \end{titlepage}}

%----------------------------------------------------------------------------------------
%	Abstract page with keywords
%----------------------------------------------------------------------------------------

\newcommand{\abstractname}{Abstract}

\DeclareDocumentEnvironment{abstract}{ o }{%
  \IfNoValueF {#1} {\begin{otherlanguage}{#1}}
      \chapter*{\abstractname}%
      % If the abstractintoc option has been passed to the class, add the abstract to the table of contents.
      \ifbool{abstractintoc}{%
        \addcontentsline{toc}{chapter}{\abstractname}}{}
      }{%
      \IfNoValueF {#1} {\end{otherlanguage}}}

\newcommand{\keywordsname}{Keywords}
\addto{\captionsenglish}{%
  \renewcommand*{\keywordsname}{Keywords}}
\addto{\captionsswedish}{%
  \renewcommand*{\keywordsname}{Nyckelord}}

\DeclareDocumentEnvironment{keywords}{}{%
  \normalfont\textbf{\keywordsname:}\ %
}{}

%----------------------------------------------------------------------------------------
%	Acknowledgements page
%----------------------------------------------------------------------------------------

\newcommand{\acknowledgementsname}{Acknowledgements}
\addto{\captionsenglish}{%
  \renewcommand*{\acknowledgementsname}{Acknowledgements}}
\addto{\captionsswedish}{%
  \renewcommand*{\acknowledgementsname}{Tackord}}

\DeclareDocumentEnvironment{acknowledgements}{}{%
  \chapter*{\acknowledgementsname}%
  % If the acknowledgementsintoc option has been passed to the class, add the acknowledgements to the table of contents.
  \ifbool{acknowledgementsintoc}{%
    \addcontentsline{toc}{chapter}{\acknowledgementsname}}{}
}{}

%----------------------------------------------------------------------------------------
%	Appendices page
%----------------------------------------------------------------------------------------

\RequirePackage[titletoc, header, page]{appendix}

\addto\captionsenglish{%
  \renewcommand\appendixpagename{Appendices}
}
\addto\captionsswedish{%
  \renewcommand\appendixpagename{Bilagor}
}

\renewenvironment{appendices}{%
  % Reset the format, kind of, of chapter.
  \DeclareDocumentCommand{\@makechapterhead}{m}{%
    {\parindent \z@ \raggedright \normalfont
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
            \huge\bfseries \@chapapp\space \thechapter
            \par\nobreak
            \vskip 20\p@
          \fi
        \fi
        \interlinepenalty\@M
        \Huge \bfseries ##1\par\nobreak}}

  % Original code of the appendix package.
  \@resets@pp
  \if@dotoc@pp
    \if@dopage@pp              % both page and toc
      \if@chapter@pp           % chapters
        \clear@ppage
      \fi
      \appendixpage
    \else                      % toc only
      \if@chapter@pp          % chapters
        \clear@ppage
      \fi
      \addappheadtotoc
    \fi
  \else
    \if@dopage@pp              % page only
      \appendixpage
    \fi
  \fi
  \if@chapter@pp
    \if@dotitletoc@pp \@redotocentry@pp{chapter} \fi
  \else
    \if@dotitletoc@pp \@redotocentry@pp{section} \fi
    \if@dohead@pp
      \def\sectionmark##1{%
      \if@twoside
        \markboth{\@formatsecmark@pp{##1}}{}
      \else
        \markright{\@formatsecmark@pp{##1}}{}
      \fi}
    \fi
    \if@dotitle@pp
      \def\sectionname{\appendixname}
      \def\@seccntformat##1{\@ifundefined{##1name}{}{\csname ##1name\endcsname\ }%
      \csname the##1\endcsname\quad}
    \fi
  \fi}{%
  \@ppsaveapp\@pprestoresec}

%----------------------------------------------------------------------------------------
%	References page
%----------------------------------------------------------------------------------------

\DefineBibliographyStrings{english}{%
  bibliography = {References}}
\DefineBibliographyStrings{swedish}{%
  bibliography = {Referenser}}

%----------------------------------------------------------------------------------------
%	References page
%----------------------------------------------------------------------------------------

\RequirePackage[colorlinks]{hyperref}

\AtBeginDocument{\hypersetup{
    allcolors=.,
    menucolor=blue,
    urlcolor=blue,
  }}
