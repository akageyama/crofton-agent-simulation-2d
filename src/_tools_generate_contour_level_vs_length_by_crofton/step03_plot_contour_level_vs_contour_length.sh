#!/bin/bash

function generate_gnuplotscript()
{
(
cat <<EOF
  # 凡例を消す
  unset key
  #
  # 軸ラベル
  set xlabel "等高線のレベル" font ",20"
  set ylabel "等高線の長さ" font ",20"
 
  # 軸の数字（目盛り）のフォントを大きくする
  set xtics font ",18"
  set ytics font ",18"
  set xrange [0:1.1]

  # 一度画面に描いてみる
  plot '_sgks.output2'

  # リターンキーで次のステップへ
  pause -1
  
  # pngファイルに出力
  set terminal pngcairo size 800,800
  set output "_level_vs_length.png"
  replot
  
  # 同じものをpdfファイルにも出力
  set terminal pdfcairo enhanced color font "Hiragino Mincho ProN,25"
  set output "_level_vs_length.pdf"
  replot
EOF
) 
}

generate_gnuplotscript > _sgks_plotsript.gp

gnuplot '_sgks_plotsript.gp'
