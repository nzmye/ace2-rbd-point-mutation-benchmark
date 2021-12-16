import argparse
import json
import pathlib
import csv

def old_csv_to_new_csv(csvFilePath, newCsvFilePath):
    with open(csvFilePath, 'w') as f2:
        fields = ['Names', 'Haddock', 'Foldx', 'Foldxwater', 'Evoef1', 'Mutabind2', 'Ssipe']
        writer=csv.DictWriter(f2,fieldnames=fields)
        writer.writeheader()
        with open( newCsvFilePath, mode='r') as infile:
            reader = csv.reader(infile)
            for i,rows in enumerate(reader):
                if i == 0:
                    header = rows
                    print(rows)
                else:
                    writer.writerow({'Names': str(rows[2]+"_"+rows[0]), 
                                    'Haddock': rows[3],
                                    'Foldx': rows[4],
                                    'Foldxwater': rows[5],
                                    'Evoef1': rows[6],
                                    'Mutabind2': rows[7],
                                    'Ssipe': rows[8]})
                    
        f2.close()


def csv_to_json(csvFilePath, jsonFilePath):
    jsonArray = []
      
    #read csv file
    with open(csvFilePath, encoding='utf-8') as csvf: 
        #load csv file data using csv library's dictionary reader
        csvReader = csv.DictReader(csvf) 

        #convert each csv row into python dict
        for row in csvReader: 
            #add this python dict to json array
            jsonArray.append(row)
  
    #convert python jsonArray to JSON String and write to file
    with open(jsonFilePath, 'w', encoding='utf-8') as jsonf: 
        jsonString = json.dumps(jsonArray, indent=4)
        jsonf.write(jsonString)



oldCsvFilePath = r'/home/nazmiye/Desktop/ibg/ace2-rbd-point-mutation-benchmark/visualize/models/ace2_rbd_example_models.csv'
csvFilePath = r'/home/nazmiye/Desktop/ibg/ace2-rbd-point-mutation-benchmark/visualize/models/newfilename.csv'
jsonFilePath = r'/home/nazmiye/Desktop/ibg/ace2-rbd-point-mutation-benchmark/visualize/models/models.json'
old_csv_to_new_csv(oldCsvFilePath, csvFilePath)
csv_to_json(csvFilePath, jsonFilePath)
