% This is a LaTeX class that helps writing the master's thesis within the computer science faculty of the University of Vienna.
% It generates the title page and creates commands to easily adjust it.
% Additionally it includes the packages needed to make a PDF-A compliance possible.

% Change log:
% Created 31.01.2019    Christoph Loitzenbauer
% Edit 04.02.2019       Christoph Loitzenbauer      Created commands for multiple line titles and names
% Edit 12.02.2019       Christoph Loitzenbauer      Updated comments

% -- Creating the class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UniVieCS_Thesis}[2019/01/31 UniVie Computer Science template for the Master's Thesis]
%\LoadClass{article} %Caution: the titlepage only fits if this class is used.
%Alternatively the following class should be possible if Din a4 is a requirement.
%caution this has not been tested extensively
%replace the LoadClass{article} it with:
%\LoadClass[a4paper]{article}
\LoadClass[a4paper, fontsize=11pt,listof=totoc,bibliography=totoc, BCOR=12mm,DIV=12]{scrbook}
%\LoadClass[footinclude=false,fontsize=11pt,paper=a4,listof=totoc,bibliography=totoc,BCOR=12mm,DIV=12]{scrbook} % two-sided % original
%\LoadClass[footinclude=false,oneside,fontsize=11pt,paper=a4,listof=totoc,bibliography=totoc,DIV=12]{scrbook} % one-sided


% -- Packages needed in the class
\RequirePackage[a-1b]{pdfx}
\RequirePackage{graphicx} % Required for including pictures
\RequirePackage[pdfa]{hyperref}
\RequirePackage[T1]{fontenc} % Required for accented characters
\RequirePackage{changepage}
\RequirePackage[final]{microtype}
\RequirePackage{xurl}

\hypersetup{
	pdfpagelayout   = TwoPageRight   
}





% -- Commands for the title page --------------

\newcommand{\TitleSetup}{MASTERARBEIT / MASTER'S THESIS}
\newcommand{\TitleTitleSetup}{Titel der Masterarbeit / Title of the Master's Thesis\par}




% -- Title of the work 
\newcommand{\TitleValue}{Titel\grqq \vspace*{\baselineskip} \vspace*{\baselineskip}}

% -- Name
\newcommand{\WhoValue}{\textgreater Akademische(r) Grad(e) Vorname Zuname Akademische(r) Grad(e)\textless \par \textgreater degree(s) first name family name degree(s)\textless \par }

% -- Desired degree
\newcommand{\DegreeValue}{Master \textgreater Zusatz\textless \hspace{0.1cm}(M \textgreater Abk\"urzung\textless) \par Master \textgreater affix\textless \hspace{0.1cm}(M \textgreater abbr.\textless) \par }

% -- Year
\newcommand{\YearGerValue}{\textgreater Jahr\textless }
\newcommand{\YearEngValue}{\textgreater Year\textless }

% -- Degree programme code
\newcommand{\ProgrammeCodeValue}{ \textgreater 000 000\textless  }

% -- Degree programme name
\newcommand{\ProgrammeNameValue}{  }

% -- Supervisors
\newcommand{\SupervisorValue}{\textgreater Akademische(r) Grad(e)  Vorname Zuname\textless \hspace{0.1cm}/}
\newcommand{\SupervisorEngValue}{ \textgreater degree(s) first name family name\textless}
\newcommand{\CoSupervisorValue}{\textgreater Akademische(r) Grad(e)  Vorname Zuname\textless \hspace{0.1cm}/}
\newcommand{\CoSupervisorEngValue}{ \textgreater degree(s) first name family name\textless}
\newcommand{\CoSupValue}{1} % ture false if there is a cosupervisor or not

% -- Commands to update the values
\newcommand{\Title}[1]{\renewcommand{\TitleValue}{#1\grqq \vspace*{\baselineskip} \vspace*{\baselineskip} }}
\newcommand{\TitleTwo}[1]{\renewcommand{\TitleValue}{#1\grqq \vspace*{\baselineskip} }}
\newcommand{\TitleThree}[1]{\renewcommand{\TitleValue}{#1\grqq}}
\newcommand{\Who}[1]{\renewcommand{\WhoValue}{#1 \vspace*{\baselineskip}}}
\newcommand{\WhoTwo}[1]{\renewcommand{\WhoValue}{#1 }}
\newcommand{\Degree}[1]{\renewcommand{\DegreeValue}{#1 \vspace*{\baselineskip} \vspace*{\baselineskip}} }
\newcommand{\YearGer}[1]{\renewcommand{\YearGerValue}{#1}}
\newcommand{\YearEng}[1]{\renewcommand{\YearEngValue}{#1}}
\newcommand{\ProgrammeCode}[1]{\renewcommand{\ProgrammeCodeValue}{#1}}
\newcommand{\ProgrammeName}[1]{\renewcommand{\ProgrammeNameValue}{#1}}
\newcommand{\Supervisor}[1]{\renewcommand{\SupervisorValue}{#1} \renewcommand{\SupervisorEngValue}{}}
\newcommand{\CoSupervisor}[1]{\renewcommand{\CoSupervisorValue}{#1}\renewcommand{\CoSupervisorEngValue}{}}
\newcommand{\SupervisorTwo}[1]{\renewcommand{\SupervisorEngValue}{#1}}
\newcommand{\CoSupervisorTwo}[1]{\renewcommand{\CoSupervisorEngValue}{#1}}
\newcommand{\Year}[1]{\YearGer{#1} \YearEng{#1}}

% -- Command to generate the titlepage
\newcommand{\Titlepage}{

	\begin{titlepage}
	    \enlargethispage{5\baselineskip}	
		\fontfamily{phv}\selectfont
		\thispagestyle{empty}
		\begin{center}
			\begin{adjustwidth}{-2cm}{-2cm}
				\vspace*{-1.3cm}
				\hspace*{11.17cm}
				%University logo
				\includegraphics[width=0.37\linewidth]{figures/logo_nontransparent.jpg}\par
				\vspace{3cm}
				\centering 	
				% Title
				{\scshape{\textbf{\huge \TitleSetup}\par}}
				\vspace{1.5cm}
				%Thesis title
				{\TitleTitleSetup\par}
				{\LARGE \glqq \TitleValue \par}
				
				\vspace{1.2cm} % If title is multiple lines long change the space here
				
				
				verfasst von / submitted by  \vspace{0.2cm}\linebreak
				{\fontsize{13}{16}\selectfont \WhoValue}
		
				
				\vspace{1.5cm} %if name is multiple lines long change the space here
				
				angestrebter akademischer Grad / in partial fulfilment of the requirements for the degree of \vspace{0.2cm}\linebreak
				{\fontsize{13}{16}\selectfont \DegreeValue \par}
				\vspace{0.8cm}
				
				%\flushleft
				
				
				\begin{tabular}{lcl}
					Wien, \YearGerValue \hspace{0.1cm}/ Vienna, \YearEngValue	\linebreak
					\vspace{2cm}&  &  \\
					Studienkennzahl lt. Studienblatt /  & \hspace{2cm}& UA \ProgrammeCodeValue \\
					degree programme code as it appears on & & \\
					the student record sheet:  & & \vspace{0.3cm} \\
					
					Studienrichtung lt. Studienblatt /  & \hspace{2cm} & \ProgrammeNameValue 
					 \\
					degree programme as it appears on & & \\
					the student record sheet: & & \vspace{0.3cm}\\
					
					Betreut von / Supervisor: & \hspace{2cm} & \SupervisorValue \\
					& \hspace{2cm} & \SupervisorEngValue \\
					\if\CoSupervisorValue0
					\else
					Mitbetreut von / Co-Supervisor: & \hspace{2cm} & \CoSupervisorValue \\
					& \hspace{2cm} & \CoSupervisorEngValue \\
					\fi
				\end{tabular}
				
				
				
				
			\end{adjustwidth}
		\end{center}
	\end{titlepage}
}