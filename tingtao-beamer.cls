%
% Copyright (c) 2022 Kangwei Xia
% Released under the LaTeX Project Public License v1.3c License.
% Repository: https://gitee.com/xkwxdyy/tingtao-beamer
% Repository: https://github.com/xkwxdyy/tingtao-beamer
%

\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\RequirePackage{xparse}
\ProvidesExplClass {tingtao-beamer} {2022-9-29} {v0.1a} {LaTeX template for tingtao beamer}

% 检查 LaTeX2e kernel 版本
\msg_new:nnn { tingtao-beamer } { latex-too-old }
  { TeX~ Live~ 2020~ or~ later~ version~ is~ required~ to~ compile~ this~ document. }
\@ifl@t@r \fmtversion { 2020/02/02 }
  { }
  { \msg_fatal:nn { tingtao-beamer } { latex-too-old } }

% 检查编译引擎，要求使用 XeLaTeX。
\msg_new:nnn { tingtao-beamer } { incompatible-engine }
  { XeLaTeX~ is~ required~ to~ compile~ this~ document. }

\sys_if_engine_xetex:F
  { \msg_fatal:nn { tingtao-beamer } { incompatible-engine } }


% 使用 l3keys 定义 \tingtaosetup 配置命令
\NewDocumentCommand \tingtaosetup { m }
  { \keys_set:nn { tingtao-beamer } {#1} }




% 加载文档类和宏包

% 处理文档类选项
\PassOptionsToClass { UTF8 , a4paper , scheme = chinese, linespread = 1.2, 10pt } { ctexbeamer }
\DeclareOption* { \PassOptionsToClass { \CurrentOption } { ctexbeamer } }
\ProcessOptions*

\RequirePackage { filehook }
\AtEndOfPackageFile* { fontspec }
  { \msg_redirect_name:nnn { fontspec } { no-script } { none } }
\AtEndOfPackageFile* { xeCJK }
  {
    \msg_redirect_name:nnn { xeCJK } { CJKfamily-redef } { none }
    \defaultCJKfontfeatures
      {
        Script  = CJK,
        Mapping = fullwidth-stop ,
      }
  }

% 载入 \cls{ctexbeamer} 文档类。
\LoadClass { ctexbeamer }

% 要求 ctex v2.4.9 2017-04-01 或更高的版本。
\msg_new:nnn { tingtao-beamer } { require-package-version }
  { The~ package~ "#1"~ is~ required. }

\@ifclasslater { ctexbeamer } { 2017/04/01 }
  { }
  {
    \msg_fatal:nnn { tingtao-beamer } { require-package-version }
      { ctex~ v2.4.9~ 2017-04-01 }
  }

% 建议在模板开始处载入全部宏包，不要轻易改变加载顺序。
\RequirePackage { etoolbox }
\RequirePackage { geometry }
\RequirePackage { fontspec }
\RequirePackage { xeCJK }
\RequirePackage { xeCJKfntef }
\RequirePackage { fancyhdr }
\RequirePackage { amsmath }
\RequirePackage { amssymb }
\RequirePackage { mathrsfs }
\RequirePackage { graphicx }


\AtEndPreamble
  {
    \RequirePackage { hyperref }
    \hypersetup
      {
        bookmarksnumbered = true,
        psdextra          = true,
        unicode           = true,
        hidelinks,
        pdfpagemode       = FullScreen
      }
      \RequirePackage { fixdif }
  }



% 对冲突的宏包报错。
\msg_new:nnn { tingtao-beamer } { package-conflict }
  { The~ "#2"~ package~ is~ incompatible~ with~ "#1". }

\cs_new:Npn \tingtao_package_conflict:nn #1#2
  {
    \AtEndOfPackageFile* {#1}
      {
        \AtBeginOfPackageFile* {#2}
          { \msg_error:nnnn { tingtao-beamer } { package-conflict } {#1} {#2} }
      }
  }

\tingtao_package_conflict:nn { unicode-math } { amscd }
\tingtao_package_conflict:nn { unicode-math } { amsfonts }
\tingtao_package_conflict:nn { unicode-math } { amssymb }
\tingtao_package_conflict:nn { unicode-math } { bbm }
\tingtao_package_conflict:nn { unicode-math } { bm }
\tingtao_package_conflict:nn { unicode-math } { eucal }
\tingtao_package_conflict:nn { unicode-math } { eufrak }
\tingtao_package_conflict:nn { unicode-math } { mathrsfs }
\tingtao_package_conflict:nn { unicode-math } { newtxmath }
\tingtao_package_conflict:nn { unicode-math } { upgreek }

\tingtao_package_conflict:nn { enumitem } { paralist }


% 列表环境
\AddToHook { env / enumerate / begin }
  {
    \addtolength { \leftmarginii } { -\labelsep }
  }



\def\beamer@cramped{}

\defbeamertemplate*{enumerate~item}{paren}
  { (\int_to_arabic:n { \c@enumi } ) }
\defbeamertemplate*{enumerate~subitem}{paren}
  { \int_to_roman:n { \c@enumii } ) }
\defbeamertemplate*{enumerate~subsubitem}{paren}{\insertenumlabel.\insertsubenumlabel.\insertsubsubenumlabel}
\defbeamertemplate*{enumerate~mini~template}{paren}{\insertenumlabel}

% 主题
% \mode<presentation> 
  % {
    % beamerthemeMadrid.sty
    \newif\ifbeamer@secheader
    \beamer@secheaderfalse

    \usecolortheme{whale}
    \usecolortheme{orchid}
    % \useinnertheme[shadow]{rounded}
    \useoutertheme{infolines}

    \ifbeamer@secheader\else\setbeamertemplate{headline}[default]\fi

    % beamerinnerthemerounded.sty
    \setbeamertemplate{blocks}[rounded][shadow=true]

    \setbeamertemplate{enumerate item}[paren]
    \setbeamertemplate{sections/subsections in toc}[ball]
    \setbeamertemplate{title~page}[default][colsep=-4bp,rounded=true,shadow=true]
    \setbeamertemplate{part~page}[default][colsep=-4bp,rounded=true,shadow=true]
    \setbeamertemplate{section~page}[default][colsep=-4bp,rounded=true,shadow=true]
    \setbeamertemplate{subsection~page}[default][colsep=-4bp,rounded=true,shadow=true]

    \setbeamercovered{transparent}
  % }

% beamerbaseauxtemplates.sty
\setbeamertemplate{section~in~toc}
  {
    \leavevmode\leftskip=2.75ex%
    \llap{
      \normalsize
      \begin{pgfpicture}{-1ex}{-0.7ex}{1ex}{1ex}
        \pgftext{\beamer@usesphere{section~number~projected}{tocsphere}}
        \pgftext{
          \usebeamerfont*{section~number~projected}%
          \usebeamercolor{section~number~projected}%
          \color{fg!90!bg}
          \inserttocsectionnumber}
      \end{pgfpicture}
      \kern1.25ex}
    \inserttocsection\par
  }
\setbeamertemplate{subsection~in~toc}
  {
    \leavevmode\leftskip=1.5em\raise0.2ex\beamer@usesphere{subsection~number~projected}{smallsphere}
    \kern1ex\inserttocsubsection\par
  }

% 强调命令
\keys_define:nn { tingtao-beamer / emph }
  {
    color .tl_set:N = \__tingtao_emph_color_tl,
    bf .bool_set:N = \__tingtao_emph_format_bfseries_bool,
    bf .default:n = true,
    bfseries .bool_set:N = \__tingtao_emph_format_bfseries_bool,
    bfseries .default:n = true,
    textbf .bool_set:N = \__tingtao_emph_format_bfseries_bool,
    textbf .default:n = true,
  }
\keys_set:nn { tingtao-beamer / emph }
  {
    color = red,
    bf = false
  }

\RenewDocumentCommand \emph { O{} m }
  {
    \group_begin:
      \keys_set:nn { tingtao-beamer / emph } {#1}
      \bool_if:NT \__tingtao_emph_format_bfseries_bool
        { \bfseries }
      \exp_args:NV \color \__tingtao_emph_color_tl
      #2
    \group_end:
  }

\NewDocumentEnvironment { emphasize } { O{} +b }
  {
    \group_begin:
      \keys_set:nn { tingtao-beamer / emph } {#1}
      \bool_if:NT \__tingtao_emph_format_bfseries_bool
        { \bfseries }
      \exp_args:NV \color \__tingtao_emph_color_tl
      #2
    \group_end:
  }{}

\NewDocumentCommand \TocBeforeSection { }
  {
    \AtBeginSection 
      {
        \begin{frame}<beamer>
          \frametitle{目录}
          \tableofcontents[currentsection,currentsubsection]
        \end{frame}
      }
  }
\NewDocumentCommand \TocBeforeSubsection { }
  {
    \AtBeginSubsection 
      {
        \begin{frame}<beamer>
          \frametitle{目录}
          \tableofcontents[currentsection,currentsubsection]
        \end{frame}
      }
  }


% 数学字体
\usefonttheme[onlymath]{serif}

% 调整字体
\setbeamerfont{block~title}{family={\CJKfamily{zhkai}},size=\normalsize}
\setbeamerfont{block~body}{family={\CJKfamily{zhkai}}}
\setbeamerfont{block~body~example}{family={\CJKfamily{zhkai}}}
\setbeamerfont{block~body~alerted}{family={\CJKfamily{zhkai}}}

\setbeamerfont{author}{family={\CJKfamily{zhkai}}}
\setbeamerfont{title}{size=\Large,family={\CJKfamily{zhkai}}}
\setbeamerfont{frametitle}{family={\CJKfamily{zhkai}}}
\setbeamerfont{footline}{family={\CJKfamily{zhkai}},size=\scriptsize}
\setbeamerfont{section~in~toc}{family={\CJKfamily{zhkai}}}
\setbeamerfont{subsection~in~toc}{family={\CJKfamily{zhkai}}}

\AtBeginDocument { \CJKfamily{zhkai} }