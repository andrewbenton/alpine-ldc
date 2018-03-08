# Tiny RPN Calculator

Like on [dlang.org][dlang], this is a small rpn calculator, but dockerized.  It's simple to build, run, and see how it works.

## Building

``` bash
docker build -t rpn-calculator .
```

## Running

``` bash
docker run -it --rm rpn-calculator
1 2 + 3 * 4 /      # example input
[2.25]             # example output
```

[dlang]: https://dlang.org
