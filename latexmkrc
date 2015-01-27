#!/usr/bin/env perl

$pdflatex        = 'lualatex -synctex=1 -halt-on-error %O %S';
$bibtex          = 'pbibtex -kanji=utf8';
$max_repeat      = 5;
$pdf_mode        = 1;
$postscript_mode = 0;
$dvi_mode        = 0;
$pvc_view_file_via_temporary = 0;

$aux_dir = './aux_files';
$out_dir = './outputs';

$pdf_previewer = "open -ga ~/Applications/Skim.app";

