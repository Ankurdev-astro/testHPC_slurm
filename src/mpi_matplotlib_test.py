import matplotlib
matplotlib.use('Agg')
import mpi4py
from mpi4py import MPI
import matplotlib.pyplot as plt
import numpy as np

def main():
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    
    if comm.rank==0:
        print(f"mpi4py file: {mpi4py.__file__}")
        print(f"mpi4py version: {mpi4py.__version__}")
    x = np.linspace(0, 10, 100)
    y = np.sin(x) + rank

    plt.figure()
    plt.plot(x, y)
    plt.title(f"Test with MPI: Process {rank}")
    plt.xlabel("x")
    plt.ylabel("y")
    plt.savefig(f"./plots/plot_rank_{rank}.png")

    print(f"Comm: {comm}, Rank: {rank}")
if __name__ == "__main__":
    main()

