import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np

def main():
    x = np.linspace(0, 10, 100)
    y = np.sin(x)

    plt.figure()
    plt.plot(x, y)
    plt.title("SLURM test Plot")
    plt.xlabel("x")
    plt.ylabel("y")
    plt.savefig("test_noMPI_plot.png")

if __name__ == "__main__":
    main()

