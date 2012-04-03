%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EE227A project: projectreport.cls
% Created by: Maximilian Balandat
% Last edited: Apr 02 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{projectreport}[2012/04/02 v0.1alpha Problem Set Class]

% Passes class options to the underlying article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions

% Load LaTeX's article class with the `titlepage' option so that \maketitle creates a title page, not just a title block
\LoadClass[11pt]{article}

% import some important packages
\usepackage{graphicx}
\usepackage{amsmath} 
\usepackage{amssymb} 
\usepackage{amsthm}
\usepackage{enumitem} % to change appearance of enum and item environments
\usepackage[noend,noline,ruled,nofillcomment]{algorithm2e} % support for typesetting altorighms

% adjust the margins using the geometry package
\usepackage[left=1in, right=1in, top=1in, bottom=1in]{geometry}

% Begin paragraphs with an empty line rather than an indent
\usepackage[parfill]{parskip}    

% customize the headers using the fancyhdr package
\usepackage{fancyhdr}
\pagestyle{fancy}
% define the header (Author and Title must be defined in document tex file)
\lfoot{\today}
\rfoot{\thepage}
\chead{}
\cfoot{}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}

% add a bunch of theorem styles
\newtheorem{proposition}{Proposition}
\newtheorem{lemma}{Lemma}
\newtheorem{theorem}{Theorem}
\newtheorem{corollary}{Corollary}
%
\theoremstyle{definition}
\newtheorem{definition}{Definition}
\newtheorem{example}{Example}[section]
%
\theoremstyle{remark}
\newtheorem{remark}{Remark}[section]

% That's all, folks!
\endinput