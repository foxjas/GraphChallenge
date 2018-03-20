#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
#include <time.h>
#include <iostream>
#include <fstream>
#include <unordered_set>
#include <vector>

using namespace std;

typedef int32_t vertexId_t;
typedef int64_t edgeId_t;
typedef int32_t degree_t;
typedef pair<vertexId_t, vertexId_t> edge_t;

const unsigned int DIRECTED = 1;
const unsigned int BIDIRECTIONAL = 2;
const unsigned int UNDIRECTED = 4;

// utility
bool sortByPairAsec(const edge_t &a, const edge_t &b) {
    if (a.first < b.first) {
      return true;
    } else if (a.first > b.first) {
      return false;
    } else {
      return (a.second < b.second);
    }
}

bool sortByPairDesc(const edge_t &a, const edge_t &b) {
    if (a.first > b.first) {
      return true;
    } else if (a.first < b.first) {
      return false;
    } else {
      return (a.second > b.second);
    }
}

bool hasOption(const char* option, int argc, char **argv) {
  for (int i = 1; i < argc; i++) {
      if (strcmp(argv[i], option) == 0)
          return true;
  }
  return false;
}

//===============================================================

/**
 * 
 */ 
void readMarket(char* inputGraphPath, unordered_set<vertexId_t> &vertices, vector<edge_t> &edges, unsigned int direction = DIRECTED) {
    vertexId_t nv = 0;
    edgeId_t ne = 0;
    const int MAX_CHARS = 1000;
    char temp[MAX_CHARS];
    char *written;
    FILE *fp = fopen(inputGraphPath, "r");

    // process input file header
    while (fgets(temp, MAX_CHARS, fp) && *temp == '%'); // skip comments
    sscanf(temp, "%d %*s %d\n", &nv,&ne); // read Matrix Market header

    // read in edges
    vertexId_t src, dst;
    while(fgets(temp, MAX_CHARS, fp) != NULL) {
        sscanf(temp, "%d %d\n", (vertexId_t*)&src, (vertexId_t*)&dst);
        src-=1;
        dst-=1;
        if (direction == DIRECTED) {
            edges.push_back(edge_t(src, dst));
        } else if (direction == BIDIRECTIONAL) {
            edges.push_back(edge_t(src, dst));
            edges.push_back(edge_t(dst, src));
        } else if (direction == UNDIRECTED) {
            edges.push_back(edge_t(min(src, dst), max(src, dst)));
        }
        vertices.insert(src);
        vertices.insert(dst);
    }

    fclose (fp);
    printf("Original input: %d vertices, %d edges\n", vertices.size(), edges.size());

    if (direction == UNDIRECTED) {
        // process to remove potential duplicates and/or self-loops
        vector<edge_t> edges_temp;
        sort(edges.begin(), edges.end(), sortByPairAsec);
        vertexId_t prev_src = -1;
        vertexId_t prev_dst = -1;
        int duplicates = 0;

        for (vector<edge_t>::iterator pair = edges.begin(); pair != edges.end(); pair++) {
            src = pair->first;
            dst = pair->second;
            if (src == prev_src && dst == prev_dst) {
                duplicates += 1;
            }  else {
                edges_temp.push_back(*pair);
                prev_src = src;
                prev_dst = dst;
            }
        }

        printf("Removed %d duplicate edges in conversion to undirected\n", duplicates);
        edges = edges_temp;
    }
}

void readSNAP(char* outPath, unordered_set<vertexId_t> &vertices, vector<edge_t> &edges, unsigned int direction = DIRECTED) {

}
    
void writeMarket(char* outPath, unordered_set<vertexId_t> &vertices, vector<edge_t> &edges, unsigned int direction = DIRECTED, bool sortAdjacencies = false, bool directedByDegree = false) {
    string direction_header;
    vector<edge_t> edges_final;
    vector<degree_t> degrees;
    unsigned int ne = edges.size();
    unsigned int nv = vertices.size();
    vertexId_t src, dst;
    if (direction == DIRECTED || direction == BIDIRECTIONAL) {
        direction_header = "general";
    } else if (direction == UNDIRECTED) {
        direction_header = "symmetric";
    }

    // enforce as only acceptable combination for directed by degree
    if (direction == DIRECTED and directedByDegree)
        degrees.resize(nv);

    if (direction == DIRECTED and not directedByDegree) {
        edges_final = edges;
    } else {
        for (edgeId_t i=0; i<ne; i++) {
            src = edges[i].first;
            dst = edges[i].second;
            if (direction == DIRECTED and directedByDegree) {
                edges_final.push_back(edge_t(src, dst));
                degrees[src] += 1;
            } else if (direction == BIDIRECTIONAL) {
                edges_final.push_back(edge_t(src, dst));
                edges_final.push_back(edge_t(dst, src));
            } else if (direction == UNDIRECTED) {
                edges_final.push_back(edge_t(min(src, dst), max(src, dst)));
            }
        }
    }

    // input MUST be bidirectional
    if (directedByDegree) {
        vector<edge_t> edges_temp;
        degree_t deg_src, deg_dst;
        for (vector<edge_t>::iterator pair = edges_final.begin(); pair != edges_final.end(); pair++) {
            src = pair->first;
            dst = pair->second;
            deg_src = degrees[src];
            deg_dst = degrees[dst];
            if ((deg_src < deg_dst) || ((deg_src == deg_dst) && (src < dst))) {
                edges_temp.push_back(*pair);
            }
        }
        edges_final = edges_temp;
        printf("Directed by degree: %d edges\n", edges_final.size());
    }

    if (sortAdjacencies || direction == UNDIRECTED) {
        cout << "Sorting adjacencies..." << endl;
        sort(edges_final.begin(), edges_final.end(), sortByPairAsec);
    }

    if (direction == UNDIRECTED) {
        direction_header = "symmetric";
        vector<edge_t> edges_temp;
        //sort(edges_final.begin(), edges_final.end(), sortByPairAsec);
        vertexId_t prev_src = -1;
        vertexId_t prev_dst = -1;
        vertexId_t src, dst;
        int duplicates = 0;
        for (vector<edge_t>::iterator pair = edges_final.begin(); pair != edges_final.end(); pair++) {
            src = pair->first;
            dst = pair->second;
            if (src == prev_src && dst == prev_dst) {
                duplicates += 1;
            } else {
                edges_temp.push_back(*pair);
                prev_src = src;
                prev_dst = dst;
            }
        }
        edges_final = edges_temp;
        printf("Removed %d duplicate edges in conversion to undirected\n", duplicates);
    }
    vector<edge_t> ().swap(edges); // deallocates edges

    // write to output
    ofstream fout;
    fout.open(outPath);
    printf("Outputting new matrix market graph: %d vertices, %d edges\n", vertices.size(), edges_final.size());
    fout << "\%\%MatrixMarket matrix coordinate pattern " << direction_header << "\n";
    fout << vertices.size() << " " <<  vertices.size() << " " << ne << "\n";
    for (edgeId_t i=0; i<ne; i++) {
        src = edges_final[i].first;
        dst = edges_final[i].second;
        fout << src+1 << " " << dst+1 << "\n";
    }
    fout.close();

}

void writeSNAP(char* outPath, unordered_set<vertexId_t> &vertices, vector<edge_t> &edges, unsigned int direction = DIRECTED) {

}


int main(const int argc, char *argv[])
{
    if (argc < 4) {
        fprintf(stderr, "Usage: <input_path> <output_path> <1|2|4> <1|2|4> [--sort] [--directed-degree]\n");
        exit(-1);
    }
    char *input_graph_path = argv[1];
    char *output_graph_path = argv[2];
    unsigned int direction_in = atoi(argv[3]);
    unsigned int direction_out = atoi(argv[4]);
    bool writeDirectedByDegree = hasOption("--sort", argc, argv);
    bool writeSortedAdjacencies = hasOption("--directed-degree", argc, argv);

    string inFileName(input_graph_path);
    string outFileName(output_graph_path);
    bool isMarketInput = inFileName.find(".mtx")==std::string::npos?false:true;
    bool isSnapInput = inFileName.find(".txt")==std::string::npos?false:true;
    bool isMarketOutput = outFileName.find(".mtx")==std::string::npos?false:true;
    bool isSnapOutput = outFileName.find(".txt")==std::string::npos?false:true;

    vector<edge_t> edges;
    unordered_set<vertexId_t> vertices;
    clock_t diff;
    clock_t start = clock();
    if (isMarketInput) {
        readMarket(input_graph_path, vertices, edges, direction_in);
    } else {
        // TODO
        readSNAP(input_graph_path, vertices, edges, direction_in);
    }

    if (isMarketInput) {
        writeMarket(output_graph_path, vertices, edges, direction_out, writeSortedAdjacencies, writeDirectedByDegree);
    } else {
        // TODO
        writeSNAP(input_graph_path, vertices, edges, direction_in);
    }
    diff = clock() - start;
    int msec = diff * 1000 / CLOCKS_PER_SEC;
    printf("Time elapsed: %d seconds %d milliseconds\n", msec/1000, msec%1000);
    return 0;
}




