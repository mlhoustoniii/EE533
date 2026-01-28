#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void matrixMultiplyCPU(float *A, float *B, float *C, int N)
{
    for (int i=0; i<N; i++)
    {
        for(int j=0; j<N; j++)
        {
            float sum = 0.0f;
            for (int k=0; k<N; k++)
            {
                sum += A[i*N + k] * B[k*N + j];
            }
                    C[i*N + j] += sum;
        }
    }
}

int main(int argc, char **argv)
{
    int N = (argc > 1) ? atoi(argv[1]) : 1024;  // receive matrix size from user; else default of size 1024
    size_t size = N * N * sizeof(float);         

    float *A = (float *)malloc(size);           // allocate memory for a maximum of 1024x1024 matrix
    float *B = (float *)malloc(size);
    float *C = (float*)malloc(size);

    for (int i=0; i<N*N; i++)                   // assign random numbers to the matrices
    {
        A[i] = rand() % 100 / 100.0f;
        B[i] = rand() % 100 / 100.0f;
    }

    clock_t start = clock();
    matrixMultiplyCPU(A,B,C,N);                 // run matrix multiplication 
    clock_t end = clock();

    double elapsed = (double)(end-start) / CLOCKS_PER_SEC;
    printf("CPU execution time (N=%d): %f seconds\n", N, elapsed);

    free(A); free(B); free(C);                  // free up the earlier-allocated memory
    return 0;
}