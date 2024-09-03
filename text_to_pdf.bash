#!/bin/bash
read -p "Enter the file name to be converted :" file enscript -p temp.ps $file
ps2pdf temp.ps analysis_results.pdf
echo
echo "Text File successfully converted to pdf."
echo
read -p "Enter Email ID :" email_id
mail -s "PDF_Output:" -A analysis_results.pdf $email_id