// Project1_SurvyingOfTheStatesPopulationIn2010.cpp : This file contains the 'main' function. Program execution begins and ends there.
//
// Created By: Andro Younan for ECE3310, Fall 2020
#include <iostream>
#include <iomanip>
using namespace std;

struct StatePopulation
{
    string state;
    double population;
};

double get_mean(StatePopulation* p, int SizeOfArray);
void Sort_population_selection_sort(StatePopulation* p, int SizeOfArray);
double get_median(StatePopulation* p, int SizeOfArray);
double get_variance(StatePopulation* p, int SizeOfArray, double Mean);
double get_standard_deviation(double Variance);

int main()
{
    int SizeOfArray;
    cout << "Enter the number of the states you would like to survey (in this project I have used the data of 50 states in 2010): ";
    cin >> SizeOfArray;         cout << endl;

    // creating a Dynamic Array where each element is an object of the Structure defined above
    StatePopulation* p = new StatePopulation[SizeOfArray];

    // Inputing the data by using Static Arrays to be used later to pass the same data to the Dynamic Array
    string states[] =
    {
        "Alabama", "Alaska", "Arizona", "Arkansas", "California",
        "Colorado", "Connecticut", "Delaware", "Florida", "Georgia",
        "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa",
        "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
        "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri",
        "Montana", "Nebraska", " Nevada", "NewHampshire", "NewJersey",
        "NewMexico", "NewYork", "NorthCarolina", "NorthDakota", "Ohio",
        "Oklahoma", "Oregon", "Pennsylvania", "RhodeIsland", "SouthCarolina",
        "SouthDakota", "Tennessee", "Texas", "Utah", "Vermont",
        "Virginia", "Washington", "WestVirginia", "Wisconsin", "Wyoming"
    };
    int populations[] =
    {
        4785401, 714146, 6413158, 2921588, 37338198,
        5047692, 3575498, 899792, 18838613, 9712157,
        1363359, 1571102, 12841980, 6490622, 3050202,
        2859143, 4347223, 4545343, 1327379, 5785681,
        6555466, 9877143, 5310658, 2970072, 5995715,
        990958, 1830141, 2704283, 1316807, 8799593,
        2065913, 19395206, 9560234, 674629, 11537968,
        3760184, 3838332, 12717722, 1052528, 4637106,
        816598, 6357436, 25253466, 2775479, 625909,
        8023953, 6742950, 1854368, 5691659, 564554
    };

    // Initializing The Dynamic Array
    for (int i = 0; i < SizeOfArray; i++)
    {
        p[i].state = states[i];
        p[i].population = populations[i];
    }

    // A test to check if the data was passed to the Dynamic Array correctly
    /*for (int i = 0;i <SizeOfArray; i++)
    {   cout << p[i].state <<"\t\t"; cout << p[i].population << endl;   }*/

    //cout << setprecision(14);  // setting the percision of the results

    // calling the functions & printing the results
    double Mean = get_mean(p, SizeOfArray);
    cout << "The Mean of state's populations in 2010: " << Mean << endl;

    double Median = get_median(p, SizeOfArray);
    cout << "The Median of the sorted state's population in 2010: " << Median << endl;

    // A test to check if the selcetion sorting algorith works correctly
    /*cout << " The state's poulation after sorting will be the follwing  \n";
    for (int i = 0; i < size; i++)
    {
        cout <<  p[i].population << "\t";
    }*/

    double Variance = get_variance(p, SizeOfArray, Mean);
    cout << "The Variance of the state's population in 2010: " << Variance << endl;

    double Standard_Deviation = get_standard_deviation(Variance);
    cout << "The Standard Deviation of the state's population in 2010: " << Standard_Deviation << endl;

    delete[] p; // releasing the memory allocated for the Dynamic Array 
    return 0;
}

double get_mean(StatePopulation* p, int SizeOfArray)
{
    double sum = 0;
    double Mean;
    for (int i = 0; i < SizeOfArray; i++)
    {
        sum += p[i].population;
    }
    Mean = sum / (SizeOfArray);
    return Mean;
}

void Sort_population_selection_sort(StatePopulation* p, int SizeOfArray)
{
    string state_temp;
    double pop_temp = 0;
    for (int i = 0; i < SizeOfArray; i++)
        for (int j = i + 1; j < SizeOfArray; j++)
        {
            if (p[j].population < p[i].population)
            {
                pop_temp = p[i].population;         state_temp = p[i].state;
                p[i].population = p[j].population;  p[i].state = p[j].state;
                p[j].population = pop_temp;         p[j].state = state_temp;
            }
        }
}

double get_median(StatePopulation* p, int SizeOfArray)
{
    // in order to calculate the median, we need to sort the data first
    Sort_population_selection_sort(p, SizeOfArray);

    // calculating the median;
    double Median = 0;
    if (SizeOfArray % 2 != 0) // if we are dealing with odd number of states
    {
        Median = p[SizeOfArray / 2].population; cout << "In case of Odd number of states, The state that has the median for year 2010 is: " << p[SizeOfArray / 2].state << endl;
    }
    else // if we are dealing with even number of states
    {
        Median = (p[(SizeOfArray - 1) / 2].population + p[SizeOfArray / 2].population) / 2.0; cout << "In case of Even number of states, The state that has the median for year 2010 cannot be determined " << endl;
    }
    return Median;
}

double get_variance(StatePopulation* p, int SizeOfArray, double Mean)
{
    double variance_numerator = 0;
    double Variance = 0;
    for (int i = 0; i < SizeOfArray; i++)
    {
        variance_numerator = variance_numerator + pow((p[i].population - Mean), 2.0);
    }
    Variance = variance_numerator / (SizeOfArray - 1);
    return Variance;
}

double get_standard_deviation(double Variance)
{
    double Standard_Deviation = sqrt(Variance);
    return Standard_Deviation;
}



