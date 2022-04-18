%
% Copyright (c) 2022 Kangwei Xia
% Released under the LaTeX Project Public License v1.3c License.
% Repository: https://gitee.com/xkwxdyy/tingtao-math
% Repository: https://github.com/xkwxdyy/tingtao-math
%

\NeedsTeXFormat{LaTeX2e}[2017/04/15]
\RequirePackage{expl3}
\RequirePackage{xparse}
\ProvidesExplClass {tingtao-math} {2022-04-18} {v0.0.1} {LaTeX template for tingtao math}

% 检查 LaTeX2e kernel 版本
\msg_new:nnn { tingtao-math } { latex-too-old }
  { TeX~ Live~ 2020~ or~ later~ version~ is~ required~ to~ compile~ this~ document. }
\@ifl@t@r \fmtversion { 2020/02/02 }
  { }
  { \msg_fatal:nn { tingtao-math } { latex-too-old } }

% 检查编译引擎，要求使用 XeLaTeX。
\msg_new:nnn { tingtao-math } { incompatible-engine }
  { XeLaTeX~ is~ required~ to~ compile~ this~ document. }

\sys_if_engine_xetex:F
  { \msg_fatal:nn { tingtao-math } { incompatible-engine } }


% 使用 l3keys 定义 \tingtaosetup 配置命令
\NewDocumentCommand \tingtaosetup { m }
  { \keys_set:nn { tingtao-math } {#1} }




% 加载文档类和宏包

% 处理文档类选项
\PassOptionsToClass { UTF8 , a4paper , scheme = chinese } { ctexbook }
\DeclareOption* { \PassOptionsToClass { \CurrentOption } { ctexbook } }
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

% 载入 \cls{ctexbook} 文档类。
\LoadClass { ctexbook }

% 要求 ctex v2.4.9 2017-04-01 或更高的版本。
\msg_new:nnn { tingtao-math } { require-package-version }
  { The~ package~ "#1"~ is~ required. }

\@ifclasslater { ctexbook } { 2017/04/01 }
  { }
  {
    \msg_fatal:nnn { tingtao-math } { require-package-version }
      { ctex~ v2.4.9~ 2017-04-01 }
  }

% 建议在模板开始处载入全部宏包，不要轻易改变加载顺序。
\RequirePackage { etoolbox }
\RequirePackage { geometry }
\RequirePackage { fontspec }
\RequirePackage { xeCJK }
\RequirePackage { xeCJKfntef }
\RequirePackage { fancyhdr }
\RequirePackage { lastpage }
\RequirePackage { amsmath }
\RequirePackage { enumitem }

\RequirePackage { tingtao-math-font }
\RequirePackage { tingtao-math-question }
\RequirePackage { tingtao-math-choices }


% 对冲突的宏包报错。
\msg_new:nnn { tingtao-math } { package-conflict }
  { The~ "#2"~ package~ is~ incompatible~ with~ "#1". }

\cs_new:Npn \tingtao_package_conflict:nn #1#2
  {
    \AtEndOfPackageFile* {#1}
      {
        \AtBeginOfPackageFile* {#2}
          { \msg_error:nnnn { tingtao-math } { package-conflict } {#1} {#2} }
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


% 纸张和页面布局

\geometry
  {
    paper  = a4paper
  }


% 字体

% 中文字体

% 在 ctex 的字体配置的基础上进行一些修改
% 将苹方和微软雅黑分别替换为华文黑体和中易黑体
\str_if_eq:onTF { \g__ctex_fontset_tl } { mac }
  {
    \setCJKsansfont { Heiti~ SC~ Light } [ BoldFont = Heiti~ SC~ Medium ]
  }
  {
    \str_if_eq:onT { \g__ctex_fontset_tl } { windows }
      { \setCJKsansfont { SimHei } }
  }

% 罗马数字使用中文字体
\xeCJKDeclareCharClass { CJK } { "2160 -> "217F }
% 带圈数字
\xeCJKDeclareCharClass { CJK } { "2460 -> "2473 }


% 如果有内容较高（如分式）使得行间距小于 0.5em，则将其增加至 0.5em。
\dim_set:Nn \lineskiplimit { .5em }
\skip_set:Nn \lineskip { .5em }





% 页眉和页脚

\tl_set:Nn \headrulewidth { 0pt }
\cs_set_eq:NN \@mkboth \use_none:n
\cs_set_eq:NN \sectionmark \use_none:n
\cs_set_eq:NN \subsectionmark \use_none:n

\pagestyle { fancy }
\fancypagestyle { plain }
  {
    \fancyhf { }
    \fancyfoot [ C ]
      {
        \small
        数学试题第 \thepage { } 页（共 \pageref { LastPage } ~ 页）
      }
  }
\pagestyle { plain }


% 设置 enumitem 列表格式
\setlist{nosep}

\setlist[enumerate, 2]{
  left       = 2em,
  labelsep   = 0pt,
  label = { （ \arabic * ） }
}



% 科目
\tl_new:N \l__exam_zh_subject_tl
\NewDocumentCommand \subject { m }
  { \tl_set:Nn \l__exam_zh_subject_tl {#1} }

% 修改标题的格式
\cs_set:Npn \@maketitle
  {
    \newpage
    \null
    \vskip 2em
    \begin { center}
      \let \footnote \thanks
      { \Large \@title \par }
      \vskip 1.5em
      { \sffamily \bfseries \huge \l__exam_zh_subject_tl }
    \end { center }
    \par
    \vskip 1.5em
  }


\prg_new_conditional:Npnn \tingtao_if_defined:N #1 { T , F , TF }
  {
    \if_meaning:w #1 \@undefined
      \prg_return_false:
    \else:
      \prg_return_true:
    \fi:
  }


% 祝考试顺利
\NewDocumentCommand \goodluck { }
  {
    \group_begin:
      \centering
      \tingtao_if_defined:NTF \lishu
        { \lishu }
        { \bfseries }
      \Large
      $\bigstar$ 祝考试顺利 $\bigstar$
      \par
    \group_end:
  }


% 注意事项环境 notice
\NewDocumentEnvironment { notice } { O { } }
  {
    \noindent
    \group_begin:
      \sffamily \bfseries
      注意事项：
    \group_end:
    \begin { enumerate }
      [
        leftmargin = 0pt ,
        itemindent = 3.5em ,
        labelsep   = 0.5em ,
        labelwidth = 1.5em ,
        align      = right ,
        label      = { \arabic * . } ,
        #1
      ]
  }
  {
    \end { enumerate }
  }


% 大题的标题使用 \ctexset 设置 \section 的格式

\ctexset
  {
    section =
      {
        format    = \heiti \bfseries ,
        number    = \chinese { section } ,
        aftername = { 、 } ,
      }
  }


% 正体的 e 和 i
\NewDocumentCommand \eu { } { \mathrm{ e } }
\NewDocumentCommand \iu { } { \mathrm{ i } }


% 兼容 siunitx v2.x 的一些命令
\AtEndOfPackageFile* { siunitx }
  {
    \ProvideDocumentCommand \unit       { } { \si }
    \ProvideDocumentCommand \qty        { } { \SI }
    \ProvideDocumentCommand \qtyproduct { } { \SI }
  }
