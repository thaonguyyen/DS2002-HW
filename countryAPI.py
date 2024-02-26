import requests
import pandas as pd
import json

def get_country_info(country_name):
    #make API call to retrieve information
    url = f"https://restcountries.com/v3.1/name/{country_name}"
    response = requests.get(url)
    #successful call
    if(response.status_code == 200):
        data = response.json() #turn to json file
        if data:
            country_data = data[0] #first matched country
            return country_data.get("capital"), country_data.get("population")
        else:
            return None, None
    else:
        return None, None

def print_json(file):
    try:
        with open(file, 'r') as file:
            data = json.load(file)
            print(json.dumps(data, indent=4)) #pretty print the JSON data
    except FileNotFoundError:
        print(f"File '{file}' not found.")
    except json.JSONDecodeError as e:
        print("Error: ", e)

def main():
    while True:
        #prompt user for country name
        country_name = input("Enter a country name: ").strip()
        capital, population = get_country_info(country_name)
        if(capital is not None and population is not None):
            print(f"Capital of {country_name}: {capital}")
            print(f"Population of {country_name}: {population}")
            #write to data frame
            df = pd.DataFrame({'Country': [country_name], 'Capital': [capital], 'Population': [population]})
            try:
                old_df = pd.read_json('country_info.json')
                new_df = pd.concat([old_df, df], ignore_index=True)
                new_df.to_json('country_info.json', orient='records', indent=4)
            except FileNotFoundError:
                df.to_json('country_info.json', orient='records', indent=4)
            except Exception as e:
                print("Error: ", e)
        else:
            print("Unable to get country info")
            break

if __name__ == "__main__":
    main()