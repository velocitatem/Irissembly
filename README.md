# 🌟 Irissembly: Iris Classification with AVR Assembly 🌟

Welcome to **Irissembly**, where cutting-edge machine learning meets low-level programming! This project showcases a decision tree classifier for iris flower classification, implemented entirely in [AVR Assembly](https://ww1.microchip.com/downloads/en/DeviceDoc/AVR-Instruction-Set-Manual-DS40002198A.pdf).

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1uuUUe4KSJ94Sp6UCfkCl2pyvcXyLa_QN?usp=sharing)

## 🚀 Project Highlights

- **🔧 Assembly Language Mastery**: Implemented using AVR Assembly, pushing the boundaries of what's possible in low-level programming.
- **🌸 Iris Classification**: Classifies iris flowers into Setosa, Versicolor, and Virginica.
- **🌲 Decision Tree Model**: Uses a decision tree with `max_depth=3` for accurate classification.

![DecisionTree](./how.png)

## 📊 Buffer Usage

Efficient buffer management is crucial for this project. Here's how the buffers are utilized:

| 0-7 | 8-15 | 16-23              | 24-31               |
|-----|------|--------------------|---------------------|
| 0   | 0    | 0                  | Petal Length Lower  |
| 0   | 0    | 0                  | Petal Length Higher |
| 0   | 0    | 0                  | Petal Width Lower   |
| 0   | 0    | Comparison Results | Petal Width Higher  |
| 0   | 0    | Comp A Lower       | Sepal Length Lower  |
| 0   | 0    | Comp A Higher      | Sepal Length Higher |
| 0   | 0    | Comp B Lower       |                     |
| 0   | 0    | Comp B Higher      | Final Result        |

The final classification result is stored at memory address `0x00800101`, which can be accessed via gdb using `(gdb) x /1x 0x00800101`.

## 🎥 Quick Demo

Check out the quick demo to see Irissembly in action!
[![asciicast](https://asciinema.org/a/lRsxFATTRUVQq0r57WIV1qiVV.svg)](https://asciinema.org/a/lRsxFATTRUVQq0r57WIV1qiVV)

Join us in exploring the fascinating intersection of assembly language and machine learning with **Irissembly**. Dive into the code and see the magic unfold!

---

Feel free to explore and contribute. Let's push the boundaries of what's possible together!
