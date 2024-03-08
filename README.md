# Irissembly

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1uuUUe4KSJ94Sp6UCfkCl2pyvcXyLa_QN?usp=sharing)


![DecisionTree](./how.png)

This project demonstrates an implementation of a decision tree classifier machine learning model implemented in [AVR Assembly](https://ww1.microchip.com/downloads/en/DeviceDoc/AVR-Instruction-Set-Manual-DS40002198A.pdf). The specific hyper parameter of this model which allows for this implementation is: `max_depth=3`


## Buffer Usage Table

This table shows how the the algorithm makes use of buffers in the microchip. The final class of the flower `['setosa' 'versicolor' 'virginica']` ... `[0-2]` is stored in the buffer `R31`.

| 0-7 | 8-15 | 16-23              | 24-31               |
|-----|------|--------------------|---------------------|
| 0   | 0    | 0                  | Petal Length Lower  |
|     |      |                    | Petal Length Higher |
|     |      |                    | Petal Width Lower   |
|     |      | Comparison Results | Petal Width Higher  |
|     |      | Comp A Lower       | Sepal Length Lower  |
|     |      | Comp A Higher      | Sepal Length Higher |
|     |      | Comp B Lower       |                     |
|     |      | Comp B Higher      | Final Result        |
