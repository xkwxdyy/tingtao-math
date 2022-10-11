%
% Copyright (c) 2022 Kangwei Xia
% Released under the LaTeX Project Public License v1.3c License.
% Repository: https://gitee.com/xkwxdyy/tingtao-math
% Repository: https://github.com/xkwxdyy/tingtao-math
%

\NeedsTeXFormat{LaTeX2e}[2017/04/15]
\RequirePackage{expl3}
\RequirePackage{xparse}
\ProvidesExplClass {tingtao-homework} {2022-10-07} {v0.1b} {LaTeX template for tingtao math homework}

% 检查 LaTeX2e kernel 版本
\msg_new:nnn { tingtao-homework } { latex-too-old }
  { TeX~ Live~ 2020~ or~ later~ version~ is~ required~ to~ compile~ this~ document. }
\@ifl@t@r \fmtversion { 2020/02/02 }
  { }
  { \msg_fatal:nn { tingtao-homework } { latex-too-old } }

% 检查编译引擎，要求使用 XeLaTeX。
\msg_new:nnn { tingtao-homework } { incompatible-engine }
  { XeLaTeX~ is~ required~ to~ compile~ this~ document. }

\sys_if_engine_xetex:F
  { \msg_fatal:nn { tingtao-homework } { incompatible-engine } }


% 使用 l3keys 定义 \tingtaosetup 配置命令
\NewDocumentCommand \tingtaosetup { m }
  { \keys_set:nn { tingtao-homework } {#1} }




% 加载文档类和宏包

% 处理文档类选项
\PassOptionsToClass { UTF8 , a4paper , scheme = chinese } { ctexart }
\DeclareOption* { \PassOptionsToClass { \CurrentOption } { ctexart } }
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

% 载入 \cls{ctexart} 文档类。
\LoadClass { ctexart }

% 要求 ctex v2.4.9 2017-04-01 或更高的版本。
\msg_new:nnn { tingtao-homework } { require-package-version }
  { The~ package~ "#1"~ is~ required. }

\@ifclasslater { ctexart } { 2017/04/01 }
  { }
  {
    \msg_fatal:nnn { tingtao-homework } { require-package-version }
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
\RequirePackage { xcolor }
\RequirePackage { amsmath }
\RequirePackage { amssymb }
\RequirePackage { mathrsfs }
\RequirePackage [ shortlabels ] { enumitem }
\RequirePackage { graphicx }
\RequirePackage { amsthm }
\RequirePackage { thmtools }

\xeCJKsetup {
  underline = {
    skip  = false ,
    depth = 0.3em ,
  },
}

\AtEndPreamble
  {
    \RequirePackage { hyperref }
    \RequirePackage { fixdif }
  }


% 对冲突的宏包报错。
\msg_new:nnn { tingtao-homework } { package-conflict }
  { The~ "#2"~ package~ is~ incompatible~ with~ "#1". }

\cs_new:Npn \tingtao_package_conflict:nn #1#2
  {
    \AtEndOfPackageFile* {#1}
      {
        \AtBeginOfPackageFile* {#2}
          { \msg_error:nnnn { tingtao-homework } { package-conflict } {#1} {#2} }
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
    paper  = a4paper,
    top    = 25.5mm,
    headheight = 15pt
  }


% 插图路径
\graphicspath{{figures/}}

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

% \tl_set:Nn \headrulewidth { 0pt }
% \cs_set_eq:NN \@mkboth \use_none:n
% \cs_set_eq:NN \sectionmark \use_none:n
% \cs_set_eq:NN \subsectionmark \use_none:n

\pagestyle { fancy }
\fancypagestyle { plain }
  {
    \fancyhf { }
    \fancyhead [ R ] { \large \kaishu \href{https://m.weishi100.com/mweb/classroom/?id=16592}{\textcolor{red}{听涛数学}} }
    \renewcommand \footrulewidth { 0.4pt }
    \fancyfoot [ R ] { \thepage }
  }
\pagestyle { plain }


% 设置 enumitem 列表格式
\setlist{nosep}

\setlist[enumerate, 2]{
  left       = 0em,
  labelsep   = 0.5em,
  itemsep    = 0.5em,
  label      = { ( \arabic * ) }
}


\def\@maketitle{%
  \newpage
  \null
  \begin{center}%
    \let \footnote \thanks
    {\LARGE \@title \par}%
    \vskip 1.5em%
    {\large \@author \par}%
    \vskip 1em%
    { \large \@date }
  \end{center}%
  \par
  \vskip 1.5em
}


% \prg_new_conditional:Npnn \tingtao_if_defined:N #1 { T , F , TF }
%   {
%     \if_meaning:w #1 \@undefined
%       \prg_return_false:
%     \else:
%       \prg_return_true:
%     \fi:
%   }


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


% 习题的计数器
\int_new:N \g__tingtao_exercise_index_int
% 填空题答案
\tl_new:N \l_tingtao_exercise_answer_tl
% 答案颜色
\tl_new:N \l__tingtao_exercise_answer_color_tl
% 是否显示括号
\bool_new:N \l__tingtao_exercise_show_paren_bool
% 是否显示答案
\bool_new:N \l__tingtao_exercise_show_answer_bool
% 上下的间距
\skip_new:N \l__tingtao_exercise_top_sep_skip
\skip_new:N \l__tingtao_exercise_bottom_sep_skip

\keys_define:nn { tingtao-homework }
  { exercise .meta:nn = { tingtao-homework / exercise } {#1} }


\keys_define:nn { tingtao-homework / exercise }
  {
    answer-color        .tl_set:N = \l__tingtao_exercise_answer_color_tl ,
    index               .int_gset:N = \g__tingtao_exercise_index_int ,
    show-paren          .bool_set:N = \l__tingtao_exercise_show_paren_bool ,
    show-answer         .bool_set:N = \l__tingtao_exercise_show_answer_bool ,
    top-sep             .skip_set:N = \l__tingtao_exercise_top_sep_skip ,
    bottom-sep          .skip_set:N = \l__tingtao_exercise_bottom_sep_skip ,
    date                .tl_set:N = \l__tingtao_exercise_date_tl,
    show-date           .bool_set:N = \l__tingtao_exercise_show_date_bool,
    label-align         .tl_set:N = \l__tingtao_exercise_label_align_tl,
  }

\keys_set:nn { tingtao-homework / exercise }
  {
    answer-color        = black ,
    show-paren          = true ,
    show-answer         = false ,
    top-sep             = .5em plus .5em minus .2em ,
    bottom-sep          = .5em plus .5em minus .2em ,
    show-date           = true,
    label-align         = right
  }



% 习题环境
\NewDocumentEnvironment { exercise } { O { } +b }
  {
    \__tingtao_exercise_begin:nn {#1}{#2}
  }
  { \__tingtao_exercise_end:nn {#1}{#2} }


\cs_new:Npn \__tingtao_exercise_begin:nn #1#2
  {
    \par
    \int_gincr:N \g__tingtao_exercise_index_int
    \tl_clear:N \l_tingtao_exercise_answer_tl
    \keys_set:nn { tingtao-homework / exercise } { #1 }
    \addvspace { \l__tingtao_exercise_top_sep_skip }
    % 严格禁止孤行和寡行
    \int_set:Nn \clubpenalty { 10000 }
    \int_set:Nn \widowpenalty { 10000 }
    % 尽量避免在题目中间换行
    \int_set:Nn \interlinepenalty { 301 }
    \int_incr:N \@enumdepth
    \list 
      { \__tingtao_exercise_index_handle: }
      % { \textbf{\thesection . \int_use:N \g__tingtao_exercise_index_int} }
      {
        \dim_set:Nn \topsep    { 0pt }
        \dim_set:Nn \partopsep { 0pt }
        \dim_set:Nn \itemsep   { 0pt }
        \dim_set:Nn \parsep    { 0pt }
        % \dim_set:Nn \leftmargin { 0pt }
        % \dim_set:Nn \itemindent { 2em }
        \dim_set:Nn \leftmargin { 2em }
        \dim_set:Nn \itemindent { 0pt }
        \dim_set:Nn \labelsep   { .7em  }
        \dim_set:Nn \labelwidth { 1.3em }
        % \dim_set:Nn \labelwidth { 1.3em }
        \dim_set_eq:NN \listparindent \itemindent
      }
    \item \relax
      \bool_if:NT \l__tingtao_exercise_show_date_bool
        {
          \tl_if_blank:VF \l__tingtao_exercise_date_tl
            { [ \textbf{\l__tingtao_exercise_date_tl} ] }
        }
  }


\cs_new:Npn \__tingtao_exercise_end:nn #1#2
  {
    #2
    \endlist
    \vspace { \l__tingtao_exercise_bottom_sep_skip }
  }


\int_new:N \g__tingtao_final_section_num_int
\AtEndDocument
  {
    \immediate\write\@auxout
      {
        \token_to_str:N \ExplSyntaxOn   % 要加一个token_to_str
        ^^J
        \int_gset:Nn \exp_not:N \g__tingtao_final_section_num_int { \thesection }
        ^^J
        \token_to_str:N \ExplSyntaxOff  % 要加一个token_to_str
      }
  }
\cs_new:Npn \__tingtao_exercise_index_handle:
  {
    \group_begin:
      \bfseries
      % 检测全文的最终 section：finalsection
      \__tingtao_exercise_make_label:n
        {
          \int_compare:nNnTF { \g__tingtao_final_section_num_int } = {0}
            {
              1. \int_use:N \g__tingtao_exercise_index_int
            }
            {
              \thesection . \int_use:N \g__tingtao_exercise_index_int
            }
        }
    \group_end:
  }

\cs_new:Npn \__tingtao_exercise_make_label:n #1
  {
    \str_case:Vn \l__tingtao_exercise_label_align_tl
      {
        { left   } { \rlap { #1 } \hss }
        { center } { \hss \clap { #1 } \hss }
        { right  } { \hss \llap { #1 } }
      }
  }
% 选择题括号
\NewDocumentCommand \paren { O { } }
  {
    \bool_if:NT \l__tingtao_exercise_show_answer_bool
      { \bool_set_true:N \l__tingtao_exercise_show_paren_bool }
    \bool_if:NT \l__tingtao_exercise_show_paren_bool
      {
        % 使括号单独成行时居于右侧
        \nobreak \hfill \allowbreak
        \null \nobreak \hfill \nobreak
        \hbox:n
          {
            (
            \hbox_to_wd:nn { 3em }
              {
                \bool_if:NT \l__tingtao_exercise_show_answer_bool
                  { \hfill \__tingtao_exercise_print_answer:n {#1} \hfill }
              }
            ) \kern -.4em
          }
      }
  }

\cs_new:Npn \__tingtao_exercise_print_answer:n #1
  {
    % \tl_set:Nn \l_tingtao_exercise_answer_tl {#1}
    \group_begin:
      \tl_if_eq:NnF \l__tingtao_exercise_answer_color_tl { black }
        { \exp_args:NV \color \l__tingtao_exercise_answer_color_tl }
      #1
    \group_end:
  }


\dim_new:N \l__tingtao_exercise_answer_depth_dim

% 填空命令
\NewDocumentCommand \fillin { s O { } }
  {
    % \tl_set:Nn \l_tingtao_exercise_answer_tl {#1}
    \bool_lazy_and:nnTF
      { \bool_if_p:N \l__tingtao_exercise_show_answer_bool }
      { \bool_not_p:n { \tl_if_empty_p:n {#2} } }
      {
        \IfBooleanTF {#1}
          { \__tingtao_exercise_fillin_adjust_depth:n {#2} }
          { \__tingtao_exercise_fillin_allow_break:n {#2} }
      }
      { \CJKunderline { \hspace* { 3em plus 1em minus 1em } } }
    \space \ignorespaces
  }

\cs_new:Npn \__tingtao_exercise_fillin_adjust_depth:n #1
  % 自动调整内容的深度防止与下划线重叠（https://gitee.com/zepinglee/tingtao-homework/issues/I4TJTN）
  {
    \hbox_set:Nn \l_tmpa_box { \__tingtao_exercise_print_answer:n {#1} }
    \dim_set:Nn \l__tingtao_exercise_answer_depth_dim
      { \box_dp:N \l_tmpa_box }
    \CJKunderline
      {
        \hspace* { 1em plus .5em minus .5em }
        \dim_compare:nNnTF { \l__tingtao_exercise_answer_depth_dim } > { 0.2em }
          {
            \dim_sub:Nn \l__tingtao_exercise_answer_depth_dim { 0.2em }
            \raisebox { \l__tingtao_exercise_answer_depth_dim }
              { \box_use_drop:N \l_tmpa_box }
          }
          { \box_use_drop:N \l_tmpa_box }
        \hspace* { 1em plus .5em minus .5em }
      }
  }

\cs_new:Npn \__tingtao_exercise_fillin_allow_break:n #1
  {
    \CJKunderline
      [ textformat = \color { \l__tingtao_exercise_answer_color_tl } ]
      {
        \hspace* { 1em plus .5em minus .5em }
          #1
        \hspace* { 1em plus .5em minus .5em }
      }
  }


\pretocmd{\section}
  {
    \int_gset:Nn \g__tingtao_exercise_index_int {0}
  }
  {}{}


% 证明环境

\RenewDocumentEnvironment { proof } { O{\proofname} +b }
  {
    \bool_if:NTF \l__tingtao_exercise_show_answer_bool
      {
        \__tingtao_proof_begin:n {#1}
          #2
        \__tingtao_proof_end:
      }
      {}
  }
  {}

\cs_set:Npn \__tingtao_proof_begin:n #1
  {
    \par
    \pushQED{\qed}
    \normalfont \topsep6\p@\@plus6\p@\relax
    \trivlist
    \item \relax
    {\itshape #1 \@addpunct{.}}
    \hspace\labelsep\ignorespaces
  }

\cs_set:Nn \__tingtao_proof_end:
  {
    \popQED\endtrivlist\@endpefalse
  }

\dim_new:N \l__tingtao_choices_column_sep_dim
\int_new:N \l__tingtao_choices_columns_int
\tl_new:N \l__tingtao_choices_label_tl
\tl_new:N \l__tingtao_choices_label_pos_tl
\tl_new:N \l__tingtao_choices_label_align_tl
\dim_new:N \l__tingtao_choices_label_sep_dim
\dim_new:N \l__tingtao_choices_label_width_dim
\int_new:N \l__tingtao_choices_max_columns_int

\keys_define:nn { tingtao-homework }
  { choices .meta:nn = { tingtao-homework / choices } {#1} }

\keys_define:nn { tingtao-homework / choices }
  {
    column-sep  .dim_set:N = \l__tingtao_choices_column_sep_dim ,
    columns     .int_set:N = \l__tingtao_choices_columns_int ,
    label       .tl_set:N  = \l__tingtao_choices_label_tl ,
    label-pos   .choices:nn =
      { auto , top-left , left , bottom }
      { \tl_set_eq:NN \l__tingtao_choices_label_pos_tl \l_keys_choice_tl } ,
    label-align .tl_set:N = \l__tingtao_choices_label_align_tl ,
    label-sep   .dim_set:N = \l__tingtao_choices_label_sep_dim ,
    label-width .dim_set:N = \l__tingtao_choices_label_width_dim ,
    max-columns .int_set:N = \l__tingtao_choices_max_columns_int ,
    index       .int_set:N = \l__tingtao_choices_item_index_int,
    % 环境上方的额外距离
    top-sep .skip_set:N = \l__tingtao_choices_top_sep_skip,
    % 环境下方的额外距离
    bottom-sep .skip_set:N = \l__tingtao_choices_bottom_sep_skip,
    % 若不是单行排版，则可以控制行之间的额外间距
    linesep .skip_set:N = \l__tingtao_choices_line_sep_skip
  }

\keys_set:nn { tingtao-homework / choices }
  {
    column-sep  = 1em ,
    columns     = 0 ,
    label       = \Alph*. ,
    label-pos   = auto ,
    label-align = left ,
    label-sep   = .5em ,
    label-width = 0pt ,
    max-columns = 4 ,
    index       = 1,
    top-sep     = 0pt,
    bottom-sep  = 0pt,
    linesep     = 0pt plus .5ex
  }

\NewDocumentCommand \setchoices { m }
  { \keys_set:nn { tingtao-homework / choices } {#1} }


\tl_new:N \l__tingtao_choices_counters_tl

\NewDocumentCommand \AddChoicesCounter { m m }
  % #1: \Alph（用户接口）
  % #2: \@Alph（具体实现的命令或函数（开发层））
  {
    % TODO 这一步的作用是什么，为什么要把函数放在 tl 变量里而不是直接在某处使用？
    % 猜测：put_right 而不是 set，是为了保证操作 label 的输入值前
    %      几个函数都被 set
    \tl_put_right:Nn \l__tingtao_choices_counters_tl
      { \__tingtao_choices_process_counter:NN #1 #2 }
    \cs_set_eq:cN { __tingtao_choices_save_ \cs_to_str:N #1 : } #2
    \cs_set_eq:cN { __tingtao_choices_save_ \cs_to_str:N #2 : } #2
  }

\AddChoicesCounter \arabic \@arabic
\AddChoicesCounter \alph   \@alph
\AddChoicesCounter \Alph   \@Alph
\AddChoicesCounter \roman  \@roman
\AddChoicesCounter \Roman  \@Roman


\dim_new:N \l__tingtao_choices_total_width_dim
\seq_new:N \l__tingtao_choices_seq

\NewDocumentEnvironment { choices } { O { } +b }
  {
    \keys_set:nn { tingtao-homework / choices } {#1}
    \par \nopagebreak
    % 严格禁止孤行和寡行
    \int_set:Nn \clubpenalty { 10000 }
    \int_set:Nn \widowpenalty { 10000 }
    % 尽量避免在选项中间换行
    \int_set:Nn \interlinepenalty { 301 }
    \vspace* { \l__tingtao_choices_top_sep_skip }
    \noindent
    % \dim_set_eq:NN \l__tingtao_choices_total_width_dim \linewidth
    \dim_set:Nn \l__tingtao_choices_total_width_dim { \linewidth - \leftskip - \rightskip }
    \int_zero:N \l__tingtao_choices_columns_int
    \dim_zero:N \l__tingtao_choices_label_width_dim
  }
  {
    % 用 \item 分割选项
    \seq_set_split:Nnn \l__tingtao_choices_seq { \item } {#2}
    % 把第一个空项去掉
    \seq_if_empty:NF \l__tingtao_choices_seq
      { \seq_pop_left:NN \l__tingtao_choices_seq \l_tmpa_tl }
    % 收集正确的选项
    \__tingtao_choices_collect_correct_choices:N   
      \l__tingtao_choices_seq
    % 计算标签和选项内容的最大自然宽度
    \__tingtao_choices_calc_max_width:N \l__tingtao_choices_seq
    % label-pos = auto 时自动选择标签位置
    \__tingtao_choices_set_auto_label_pos:
    % 如果用户没有声明列数，计算合适的列数
    % 「学习点」从默认值是否被改变来测试用户是否输入
    % 用户没有输入的话就采用自动计算列数
    \int_compare:nNnT { \l__tingtao_choices_columns_int } < {1}
      { \__tingtao_choices_calc_columns: }
    % 计算每个选项内容的宽度 \l__tingtao_choices_item_width_dim
    \__tingtao_choices_calc_item_width:
    % 输出选项
    \__tingtao_print_choices:N \l__tingtao_choices_seq
    % 输出正确选项
    \__tingtao_print_correctchoice:
    \vspace* { \l__tingtao_choices_bottom_sep_skip }
  }

% 用来存正确选项的序号（entry）
\seq_new:N \l__tingtao_choices_correct_choices_label_seq
% 用来存正确选项的内容
\seq_new:N \l__tingtao_choices_correct_choices_item_seq

% 收集正确的选项，保存在 \l__tingtao_choices_correct_choices_seq
\cs_new:Npn \__tingtao_choices_collect_correct_choices:N #1
  % #1: \l__tingtao_choices_seq
  {
    \seq_clear:N \l__tingtao_choices_correct_choices_label_seq
    \seq_clear:N \l__tingtao_choices_correct_choices_item_seq
    \seq_clear:N \l_tmpa_seq
    \seq_map_indexed_inline:Nn #1
      {
        % ##1: 选项序号
        % ##2: 选项内容
        % 如果分割后，第一个字符是 * 的，表明这是一个正确选项
        %（即用 \item* 来标记正确答案）
        \tl_if_head_eq_meaning:nNTF {##2} *
          {
            \seq_put_right:Nn \l__tingtao_choices_correct_choices_label_seq 
              { \__tingtao_choices_correct_choices_label_transfrom:n {##1} }
            % 将去掉 * 号后的内容保存进 \l_tmpa_tl
            \tl_set:Nx \l_tmpa_tl { \tl_tail:n {##2} }
            % 去掉 * 和内容之间的空格
            \tl_trim_spaces:N \l_tmpa_tl
            \seq_put_right:NV \l__tingtao_choices_correct_choices_item_seq 
              \l_tmpa_tl 
            \seq_put_right:NV \l_tmpa_seq \l_tmpa_tl
          }
          {
            \seq_put_right:Nn \l_tmpa_seq { ##2 }
          }
      }
    \seq_set_eq:NN #1 \l_tmpa_seq
  }

% 根据 label 的样式 \l__tingtao_choices_label_tl 转化正确选项的样式
\cs_new:Npn \__tingtao_choices_correct_choices_label_transfrom:n #1
  {
    \group_begin:
      \int_set:Nn \l__tingtao_choices_index_int {#1}
      % 定义计数器转换函数（如 \Alph 等）
      \l__tingtao_choices_counters_tl
      % 输出
      \l__tingtao_choices_label_tl
    \group_end:
  }
% 输出正确的选项
\cs_new:Nn \__tingtao_print_correctchoice:
  {
    \seq_if_empty:NF \l__tingtao_choices_correct_choices_item_seq
      {
        \par
        参考答案：
        \seq_use:Nn \l__tingtao_choices_correct_choices_label_seq {,~}
      }
  }


\dim_new:N \l__tingtao_choices_item_width_dim
\dim_new:N \l__tingtao_choices_item_min_height_dim

% 计算标签和选项内容的最大宽度，
% 分别保存到 \l__tingtao_choices_label_width_dim 和 \l__tingtao_choices_item_width_dim
% #1: \l__tingtao_choices_seq
\cs_new:Npn \__tingtao_choices_calc_max_width:N #1
  {
    % 下面这两个的想法是 xchoices 项目可以优化学习的地方
    % 因为 xchoices 是把变量先设置为第一项的参数，然后让后面的和前面的比
    % 这里相当于把“设置为第一项的参数”这一步，用默认的“端点量”来代替
    % 比如取最大的，就和 0 比，这样的话其实也会产生变量会变成第一项的参数的结果
    % 但是两者性质不同，此处处理让 第一项 「没有特殊性」
    % 后面的计算最小高度的也是如此
    \dim_zero:N \l__tingtao_choices_item_width_dim
    \dim_set_eq:NN \l__tingtao_choices_item_min_height_dim \c_max_dim
    \seq_map_indexed_inline:Nn #1
      {
        % -- 标签 --
        % 把标签整体放进 \l_tmpa_box
        \hbox_set:Nn \l_tmpa_box { \__tingtao_choices_the_label:n {##1} }
        % 测量宽度
        \dim_set:Nn \l_tmpa_dim { \box_wd:N \l_tmpa_box }
        % 与当前最大值比较，最后效果是 \l__tingtao_choices_label_width_dim 储存了所有标签中宽度最大的标签的宽度值
        \dim_compare:nNnT
          { \l_tmpa_dim } > { \l__tingtao_choices_label_width_dim }
          { \dim_set_eq:NN \l__tingtao_choices_label_width_dim \l_tmpa_dim }
        % -- 选项内容 --
        % 把内容放进 \l_tmpa_box 中
        \hbox_set:Nn \l_tmpa_box {##2}
        % 测量宽度
        \dim_set:Nn \l_tmpa_dim { \box_wd:N \l_tmpa_box }
        % 与当前最大值比较，最后效果是 \l__tingtao_choices_item_width_dim 储存了所有选项内容中宽度最大的内容的宽度值
        \dim_compare:nNnT
          { \l_tmpa_dim } > { \l__tingtao_choices_item_width_dim }
          {
            \dim_set_eq:NN \l__tingtao_choices_item_width_dim
              \l_tmpa_dim
          }
        % -- 找到最小高度 --
        % 把内容高度储存到 \l_tmpb_dim
        \dim_set:Nn \l_tmpb_dim { \box_ht:N \l_tmpa_box }
        % 与当前最小值比较，最后效果是 \l__tingtao_choices_item_min_height_dim 储存了所有内容中高度最小的内容的高度值
        \dim_compare:nNnT
          { \l_tmpb_dim } < { \l__tingtao_choices_item_min_height_dim }
          { \dim_set_eq:NN \l__tingtao_choices_item_min_height_dim \l_tmpb_dim }
        \box_clear:N \l_tmpa_box
      }
  }

% TODO 没看懂怎么实现的
\int_new:N \l__tingtao_choices_index_int

% \Alph* 形式生成正确的标签
\cs_new:Npn \__tingtao_choices_the_label:n #1
  {
    \group_begin:
      \int_set:Nn \l__tingtao_choices_index_int 
        {
          \int_eval:n
            {
              \l__tingtao_choices_item_index_int + #1 - 1
            }
        }
      \l__tingtao_choices_counters_tl
      \l__tingtao_choices_label_tl
    \group_end:
  }

\cs_new:Npn \__tingtao_choices_process_counter:NN #1#2
  % #1: \Alph
  % #2: \@Alph
  {
    % 用户可以同时使用 #1 和 #2 两个函数（命令）作为 label 的操作函数
    % #1 的内核原理函数是 #2
    \cs_set:Npn #1 { \__tingtao_choices_process_counter_aux:Nn #2 }
    \cs_set:Npn #2 { \__tingtao_choices_process_counter_aux:Nn #2 }
  }

\cs_new:Npn \__tingtao_choices_process_counter_aux:Nn #1#2
  % #1: \@Alph
  {
    \tl_if_eq:nnTF {#2} { * }
      {
        % 如果是 \alph* 类型的，效果为 \alph{ \l__tingtao_choices_index_int }
        \use:c { __tingtao_choices_save_ \cs_to_str:N #1 : }
          { \l__tingtao_choices_index_int }
      }
      {
        % 否则就是 \alph{...} 效果
        \use:c { __tingtao_choices_save_ \cs_to_str:N #1 : } {#2}
      }
  }


% 超过这一高度阈值的选项视为插图模式
% 注意使用 tl
% TODO 为何要使用 tl 而不用 dim ？
\tl_new:N \l__tingtao_choices_figure_mode_threshold_tl
\tl_set:Nn \l__tingtao_choices_figure_mode_threshold_tl { 2 \baselineskip }

\cs_new:Npn \__tingtao_choices_set_auto_label_pos:
  {
    \tl_if_eq:NnT \l__tingtao_choices_label_pos_tl { auto }
      {
        % 若最小高度超过阈值，推测其中包含插图，将标签位置改为左居中
        \dim_compare:nNnTF
          { \l__tingtao_choices_item_min_height_dim } >
            { \l__tingtao_choices_figure_mode_threshold_tl }
          { \tl_set:Nn \l__tingtao_choices_label_pos_tl { left } }
          { \tl_set:Nn \l__tingtao_choices_label_pos_tl { top-left } }
      }
  }


\int_new:N \l__tingtao_tmp_int

% 计算选项的合适列数，存到 \l__tingtao_choices_columns_int
\cs_new:Npn \__tingtao_choices_calc_columns:
  {
    % 若标签不在底部，将 label-width 和 label-sep 加到 \l__tingtao_choices_item_width_dim 里面
    \tl_if_eq:NnF \l__tingtao_choices_label_pos_tl { bottom }
      {
        \dim_add:Nn \l__tingtao_choices_item_width_dim
          { \l__tingtao_choices_label_width_dim + \l__tingtao_choices_label_sep_dim }
      }
    % [总宽度 / 最大的选项宽度] = 列数 
    % 这个计算出来是作为「算出来的、可以排的最大列数」
    % 将要和下面的手动（或者默认的）最大列数进行比较，来确定最后排多少列
    \int_set:Nn \l__tingtao_choices_columns_int
      {
        \int_div_truncate:nn
          { \l__tingtao_choices_total_width_dim + \l__tingtao_choices_column_sep_dim }
          { \l__tingtao_choices_item_width_dim + \l__tingtao_choices_column_sep_dim }
      }
    % 如果上面的计算算出来是 0 的话，就设置为 1
    \int_compare:nNnTF { \l__tingtao_choices_columns_int } = {0}
      { \int_set:Nn \l__tingtao_choices_columns_int {1} }
    % 从允许的最大列数开始，每次除以 2，直到行宽允许排下
    % 比如设置了最大列数是 4 ， 但是算出来可以排 5 
    % 那么就会将 [4 / 2] = 2 < 5 作为列数
    \int_set_eq:NN \l__tingtao_tmp_int \l__tingtao_choices_max_columns_int
    \int_while_do:nNnn
      { \l__tingtao_tmp_int } > { \l__tingtao_choices_columns_int }
      {
        \int_set:Nn \l__tingtao_tmp_int
          { \int_div_truncate:nn { \l__tingtao_tmp_int } {2} }
      }
    \int_set_eq:NN \l__tingtao_choices_columns_int \l__tingtao_tmp_int
  }


% 计算选项的最终宽度，保存到 \l__tingtao_choices_item_width_dim
\cs_new:Npn \__tingtao_choices_calc_item_width:
  {
    \dim_set:Nn \l__tingtao_choices_item_width_dim
      {
        % TODO 不是很理解这里的算法
        ( \l__tingtao_choices_total_width_dim
          - \l__tingtao_choices_columns_int \l__tingtao_choices_column_sep_dim
          + \l__tingtao_choices_column_sep_dim
        ) / \l__tingtao_choices_columns_int
      }
    % 若标签不在底部，将 label-width 和 label-sep 算进来
    % TODO 算进来？那怎么还是 sub？
    \tl_if_eq:NnF \l__tingtao_choices_label_pos_tl { bottom }
      {
        \dim_sub:Nn \l__tingtao_choices_item_width_dim
          { \l__tingtao_choices_label_width_dim + \l__tingtao_choices_label_sep_dim }
      }
  }


\int_new:N \l__tingtao_choices_current_col_int

% #1: \l__tingtao_choices_seq
\cs_new:Npn \__tingtao_print_choices:N #1
  {
    \int_zero:N \l__tingtao_choices_current_col_int
    \seq_map_indexed_inline:Nn \l__tingtao_choices_seq
      {
        \int_incr:N \l__tingtao_choices_current_col_int
        % 当前列号重置为 1
        \int_compare:nNnT
          { \l__tingtao_choices_current_col_int } > { \l__tingtao_choices_columns_int }
          {
            % \par \noindent
            \\[ \l__tingtao_choices_line_sep_skip ]
            % \newline
            % \skip_vertical:N \l__tingtao_choices_line_sep_skip
            \int_set:Nn \l__tingtao_choices_current_col_int {1}
          }
        % TODO 为什么 > 1 才加呢？ 这样的话第 1 列和第 2 列之间就没有这个间距？
        \int_compare:nNnT { \l__tingtao_choices_current_col_int } > {1}
          {
            \skip_horizontal:N \l__tingtao_choices_column_sep_dim
            % 增加一点弹性
            \skip_horizontal:n {0pt plus 1pt minus 1pt}
          }
        \__tingtao_print_single_choice:nn {##1} {##2}
      }
    \par
  }


\coffin_new:N \l__tingtao_choices_item_coffin
\coffin_new:N \l__tingtao_choices_label_coffin
% \box_new:N \l__tingtao_choices_item_box
% \box_new:N \l__tingtao_choices_label_box
\cs_new:Npn \__tingtao_print_single_choice:nn #1#2
  {
    % 选项标签
    \__tingtao_choices_make_label_coffin:n {#1}
    % \__tingtao_choices_make_label_box:n {#1}
    % 选项内容
    \__tingtao_choices_make_item_coffin:n {#2}
    % \__tingtao_choices_make_item_box:n {#2}
    % 合并选项的标签和内容
    \str_case:Vn \l__tingtao_choices_label_pos_tl
      {
        { top-left }
          {
            \coffin_join:NnnNnnnn
              \l__tingtao_choices_label_coffin {r} {H}
              \l__tingtao_choices_item_coffin  {l} {H}
              { \l__tingtao_choices_label_sep_dim }
              { 0pt }
            % \hbox_set:Nn \l__tingtao_choices_item_box
            %   {
            %     \box_use_drop:N \l__tingtao_choices_label_box
            %     \kern \l__tingtao_choices_label_sep_dim
            %     \box_use_drop:N \l__tingtao_choices_item_box
            %   }
          }
        { left }
          {
            \coffin_join:NnnNnnnn
              \l__tingtao_choices_label_coffin {r} {vc}
              \l__tingtao_choices_item_coffin  {l} {vc}
              { \l__tingtao_choices_label_sep_dim }
              { 0pt }
            % \hbox_set:Nn \l__tingtao_choices_item_box
            %   {
            %     \box_move_down:nn
            %       {
            %         (
            %           \box_ht:N \l__tingtao_choices_label_box -
            %           \box_dp:N \l__tingtao_choices_label_box -
            %           \box_ht:N \l__tingtao_choices_item_box +
            %           \box_dp:N \l__tingtao_choices_item_box
            %         ) / 2
            %       }
            %       { \box_use_drop:N \l__tingtao_choices_label_box }
            %     \kern \l__tingtao_choices_label_sep_dim
            %     \box_use_drop:N \l__tingtao_choices_item_box
            %   }
          }
        { bottom }
          {
            \coffin_join:NnnNnnnn
              \l__tingtao_choices_label_coffin {hc} {t}
              \l__tingtao_choices_item_coffin  {hc} {b}
              { 0pt }
              % { - \l__tingtao_choices_label_sep_dim }
              { 0pt }
            % \hbox_set:Nn \l__tingtao_choices_item_box
            %   {
            %     % \vbox_top:n
            %     %   {
            %     %     \box_use:N \l__tingtao_choices_item_box
            %     %     \nointerlineskip
            %     %     % \kern \l__tingtao_choices_label_sep_dim 
            %     %     \box_move_left:nn
            %     %       {
            %     %         (
            %     %           \box_wd:N \l__tingtao_choices_label_box -
            %     %           \box_wd:N \l__tingtao_choices_item_box
            %     %         ) / 2
            %     %       }
            %     %       { \box_use_drop:N \l__tingtao_choices_label_box }
            %     %       \box_clear:N \l__tingtao_choices_item_box
            %     %   }
            %     \hbox_set:Nn \l__tingtao_choices_item_box
            %       {
            %         \box_use:N \l__tingtao_choices_item_box
            %         \kern \dim_eval:n
            %           {
            %             ( - \box_wd:N \l__tingtao_choices_label_box
            %               -  \box_wd:N \l__tingtao_choices_item_box ) / 2 
            %           }
            %         \box_move_down:nn
            %           {
            %             \box_ht:N \l__tingtao_choices_label_box +
            %             \box_dp:N \l__tingtao_choices_item_box
            %             % + \l__tingtao_choices_label_sep_dim 
            %           }
            %           { \box_use_drop:N \l__tingtao_choices_label_box }
            %         \box_clear:N \l__tingtao_choices_item_box
            %       }
            %   }
          }
      }
    % 输出合并后
    % \coffin_typeset:Nnnnn \l__tingtao_choices_item_coffin {l} {H} {0pt} {0pt}
    \coffin_typeset:Nnnnn \l__tingtao_choices_label_coffin {l} {H} {0pt} {0pt}
    \coffin_clear:N \l__tingtao_choices_item_coffin
    \coffin_clear:N \l__tingtao_choices_label_coffin
    % \box_use_drop:N \l__tingtao_choices_item_box
  }

% 将标签内容存入 coffin
\cs_new:Npn \__tingtao_choices_make_label_coffin:n #1
% 将标签内容存入 box
% \cs_new:Npn \__tingtao_choices_make_label_box:n #1
  {
    \hcoffin_set:Nn \l__tingtao_choices_label_coffin
    % \hbox_set:Nn \l__tingtao_choices_label_box
      {
        \hbox_to_wd:nn { \l__tingtao_choices_label_width_dim }
          { \__tingtao_choices_make_label:n {#1} \strut }
      }
  }

\cs_new:Npn \__tingtao_choices_make_label:n #1
  {
    \str_case:Vn \l__tingtao_choices_label_align_tl
      {
        { left   } { \rlap { \__tingtao_choices_the_label:n {#1} } \hss }
        { center } { \hss \clap { \__tingtao_choices_the_label:n {#1} } \hss }
        { right  } { \hss \llap { \__tingtao_choices_the_label:n {#1} } }
      }
  }

\bool_new:N \l__tingtao_choices_figure_mode_bool

% 将选项内容存入 coffin
\cs_new:Npn \__tingtao_choices_make_item_coffin:n #1
% 将选项内容存入 box
% \cs_new:Npn \__tingtao_choices_make_item_box:n #1
  {
    \hcoffin_set:Nn \l__tingtao_choices_item_coffin
    % \hbox_set:Nn \l__tingtao_choices_item_box
      {
        % 优先尝试使用 hbox，这是因为在 \vbox_set 外部能保留原来的 \linewidth 和
        % \textwidth，方便用户在 \includegraphics 中使用
        \hbox_set:Nn \l_tmpa_box {#1}
        % 若盒子的自然高度大于 2 行，且深度为 0pt，设置为插图模式
        \bool_lazy_and:nnT
          {
            \dim_compare_p:nNn { \box_ht:N \l_tmpa_box } >
            { \l__tingtao_choices_figure_mode_threshold_tl }
          }
          { \dim_compare_p:nNn { \box_dp:N \l_tmpa_box } < { 1pt } }
          { \bool_set_true:N \l__tingtao_choices_figure_mode_bool }
        \vcoffin_set:Nnn \l_tmpa_coffin
          { \l__tingtao_choices_item_width_dim }
        % \vbox_set:Nn \l_tmpa_box
          {
            % \dim_set_eq:NN \parskip \c_zero_dim
            % \dim_set_eq:NN \parindent \listparindent
            \dim_set_eq:NN \hsize \l__tingtao_choices_item_width_dim
            \dim_set_eq:NN \linewidth \hsize
            \dim_set_eq:NN \columnwidth \hsize
            \dim_set_eq:NN \parskip \c_zero_dim
            \dim_set_eq:NN \parindent \listparindent
            \dim_set:Nn \leftskip { 0pt }
            \dim_set:Nn \rightskip { 0pt }
            \noindent
            % \strut
            % 若标签在底部，将图片居中对齐。
            \tl_if_eq:NnT \l__tingtao_choices_label_pos_tl { bottom }
              { \centering }
            \dim_compare:nNnTF
              { \box_wd:N \l_tmpa_box } > { \l__tingtao_choices_item_width_dim }
              { #1 }
              { \box_use_drop:N \l_tmpa_box }
            % 使用 \strut 将行距撑开，防止跟下一行选项的间距过小
            \mode_if_horizontal:T { \strut }
          }
        \dim_set:Nn \l_tmpa_dim { \coffin_ht:N \l_tmpa_coffin }
        \bool_if:NT \l__tingtao_choices_figure_mode_bool
        % \dim_set:Nn \l_tmpa_dim { \box_ht:N \l_tmpa_box }
        % \bool_if:NTF \l__tingtao_choices_figure_mode_bool
        %   {
        %     \box_move_up:nn { \l_tmpa_dim - 0.7 \baselineskip } { \box_use_drop:N \l_tmpa_box }
        %   }
          {
            \coffin_set_horizontal_pole:Nnn \l_tmpa_coffin {T}
              { \l_tmpa_dim - 0.7 \baselineskip }
            % \vbox_top:n { \vbox_unpack_drop:N \l_tmpa_box }
          }
        \coffin_typeset:Nnnnn \l_tmpa_coffin {l} {T} {0pt} {0pt}
        \coffin_clear:N \l_tmpa_coffin
      }
  }


% 使用中文字体直接输出 unicode 带圈数字
% \circlednumber 的参数既可以接受 LaTeX2e 的 <counter>，也可以直接接受 <intexpr>。
% \NewDocumentCommand \circlednumber { m }
%   {
%     \int_if_exist:cTF { c@ #1 }
%       { \int_set_eq:Nc \l_tmpa_int { c@#1 } }
%       { \int_set:Nn \l_tmpa_int { #1 } }
%     \exp_args:Nx \__tingtao_choices_circled_number:n { \int_use:N \l_tmpa_int }
%   }

\cs_new:Npn \__tingtao_choices_circled_number:n #1
  {
    \int_set:Nn \l_tmpa_int {#1}
    \int_compare:nNnTF { \l_tmpa_int } = { 0 }
      { \int_set:Nn \l_tmpa_int { "24EA } }
      {
        \int_compare:nNnTF { \l_tmpa_int } < { 21 }
          { \int_add:Nn \l_tmpa_int { "245F } }
          {
            \int_compare:nNnTF { \l_tmpa_int } < { 36 }
              { \int_add:Nn \l_tmpa_int { "3250 } }
              {
                \int_compare:nNnTF { \l_tmpa_int } < { 51 }
                  { \int_add:Nn \l_tmpa_int { "32B0 } }
                  {
                    \msg_error:nnn { tingtao-homework / choices }
                      { invalid-circled-number } { \int_use:N \l_tmpa_int }
                  }
              }
          }
      }
    \group_begin:
      % TODO 为何要用 \CJKfamily+ { }
      % xeCJK 宏包文档：当 \CJKfamily+ 参数为空时，则使用当前的 CJK 字体族。
      \CJKfamily+ { }
      \symbol { \l_tmpa_int }
    \group_end:
  }

\msg_new:nnn { tingtao-homework / choices } { invalid-circled-number }
  { Invalid~ circled~ number~ #1. }

\AddChoicesCounter \circlednumber \__tingtao_choices_circled_number:n


% 强调命令
\keys_define:nn { tingtao-homework / emph }
  {
    color .tl_set:N = \__tingtao_emph_color_tl,
    bf .bool_set:N = \__tingtao_emph_format_bfseries_bool,
    bf .default:n = true,
    bfseries .bool_set:N = \__tingtao_emph_format_bfseries_bool,
    bfseries .default:n = true,
    textbf .bool_set:N = \__tingtao_emph_format_bfseries_bool,
    textbf .default:n = true,
  }
\keys_set:nn { tingtao-homework / emph }
  {
    color = red,
    bf = false
  }

\RenewDocumentCommand \emph { O{} m }
  {
    \group_begin:
      \keys_set:nn { tingtao-homework / emph } {#1}
      \bool_if:NT \__tingtao_emph_format_bfseries_bool
        { \bfseries }
      \exp_args:NV \color \__tingtao_emph_color_tl
      #2
    \group_end:
  }