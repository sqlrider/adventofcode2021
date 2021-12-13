// https://adventofcode.com/2021/day/12
// Part 1

using System.Reflection;

string inputpath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + "\\puzzleinput.txt";

var puzzleinput = File.ReadAllLines(inputpath);

// Reorder input so Start is first cave
for (int i = 1; i < puzzleinput.Length; i++)
{
    if (puzzleinput[i].Contains("start-"))
    {
        var tmp = puzzleinput[0];
        puzzleinput[0] = puzzleinput[i];
        puzzleinput[i] = tmp;

        break;
    }
}

foreach(string line in puzzleinput)
{
    Console.WriteLine(line);
}

// Need a traversal function to be recursively called to traverse the nodes
void Traverse (Cave inputcave, List<string> visited_caves_input, List<string> route_caves_input, ref List<List<string>> routes, ref List<Cave> caves)
{
    // Need to create new Lists here otherwise they're passed by reference and break the algorithm
    List<string> visited_caves = new List<string>(visited_caves_input);
    List<string> route_caves = new List<string>(route_caves_input);

    if (route_caves[(route_caves.Count - 1)] == "end")
    {
        routes.Add(route_caves);
        Console.WriteLine("{0}", String.Join(",",route_caves));
    }

    if (!visited_caves.Contains(inputcave.Name))
    {
        if (inputcave.Name.ToLower() == inputcave.Name)
        {
            visited_caves.Add(inputcave.Name);
        }

        route_caves.Add(inputcave.Name);

        foreach(string connectedcave in inputcave.ConnectedCaves)
        {
            foreach(Cave cave in caves)
            {
                if (cave.Name == connectedcave)
                {
                    //Console.WriteLine("We are doing a traversal from {0} to {1}", inputcave.Name, cave.Name);
                    Traverse(cave, visited_caves, route_caves, ref routes, ref caves);
                }
            }
        }
    }
}



List<Cave> caves = new List<Cave>();

List<string> caveslist = new List<string>();

// First get unique list of caves
foreach (string row in puzzleinput)
{
    string[] pair = row.Split('-');

    for (int i = 0; i <= 1; i++)
    {
        if (!caveslist.Contains(pair[i]))
        {
            caveslist.Add(pair[i]);
        }
    }
}

// Now populate caves array
foreach (string cave in caveslist)
{
    if (cave.ToUpper() == cave)
    {
        caves.Add(new Cave(cave));
    }
    else
    {
        caves.Add(new Cave(cave));
    }

}

// Add links between caves
foreach (string row in puzzleinput)
{
    string[] pair = row.Split('-');

    foreach(Cave cave in caves)
    {
        if (cave.Name == pair[0])
        {
            cave.ConnectedCaves.Add(pair[1]);
        }
    }
}

foreach (string row in puzzleinput)
{
    string[] pair = row.Split('-');

    foreach(Cave cave in caves)
    {
        if (cave.Name == pair[1])
        {
            cave.ConnectedCaves.Add(pair[0]);
        }
    }
}

List<string> visitedcaves = new List<string>();
visitedcaves.Add("."); // Need to add dummy value as can't pass empty array

List<string> routecaves = new List<string>();
routecaves.Add("."); // Need to add dummy value as can't pass empty array

List<List<string>> routes = new List<List<string>>();

Traverse(caves[0], visitedcaves, routecaves, ref routes, ref caves);

// This is a hack as there is clearly 3x duplication in the output (due to 'start' having 3 paths by the looks of it, as it's 2x for start having two paths),
// but I couldn't get a method of removing duplicates working...
int uniqueroutes = routes.Count / 3;

Console.WriteLine("Total valid routes = {0}", uniqueroutes);


// Why not create a cave class
public class Cave
{
    public Cave(string cavename)
    {
        this.Name = cavename;
        this.ConnectedCaves = new List<string>();
    }

    public string Name;

    // This could be an array of pointers to other Caves but it would just mean pulling their values as an extra step
    public List<string> ConnectedCaves;
}