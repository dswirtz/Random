import PyPDF2
import glob
import csv
import sys

pdf_data = []
files = glob.glob("filepath")
# pdf = open("filepath", "rb")

for f in files:
    pdf = open(f, 'rb')
    pdfReader = PyPDF2.PdfFileReader(pdf)
    pageObj = pdfReader.getPage(0)
    txt = pageObj.extractText()
    pdf_data.append(txt)

 
pdf_data_txt = open('filepath/output.txt', 'w')
for row in pdf_data:
    pdf_data_txt.write("%s\n" % row)

#sys.stdout.close()

'''
with open('filepath/output.csv', 'w') as output:
    wr = csv.writer(output)
    wr.writerows(pdf_data)
#print(pdf_data)
'''