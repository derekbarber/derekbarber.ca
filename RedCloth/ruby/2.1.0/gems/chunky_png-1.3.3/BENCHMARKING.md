# ChunkyPNG benchmark suite

I would like the performance of this library as good as possible, and I will
gladly accept changes to this library that improves performance.

The library comes with a basic benchmark suite is intended to test the speed
of PNG decoding and encoding against different ruby interpreters. Execute them
using rake. You can set the number of runs by passing the N environment variable.

    bundle exec rake benchmark:encoding
    bundle exec rake benchmark:decoding

    bundle exec rake benchmark N=10      # Run all of them with 10 iterations

You can use rvm to run the benchmarks against different interpreters. Of course,
make sure that the chunky_png is installed for all your interpreters.

    rvm 1.8.7,1.9.3,rbx bundle exec rake benchmark N=10

## Results

What is a speed improvement on one interpreter doesn't necessarily mean the
performance will be better on other interpreters as well. Please make sure to
benchamrk different RUby interpreters. When it comes to different Ruby
interpreters, the priority is the performance on recent MRI versions.

Some very old benchmark result (using N=50) on my 2007 iMac can be found in
[this gist](https://gist.github.com/wvanbergen/495323).

## Why is this relevant?

ChunkyPNG is a pure Ruby library to handle PNG files. Decoding a PNG requires
a lot of integer math and bitwise operations, and moderate use of the unpack
method to read binary data. Encoding is a good test for `Array#pack`, and
depending on the encoding options, also requires a lot of calculations.
Therefore, the library is a good benchmark candidate for these methods and
algorithms. It has been used to improve the `Array#pack` and `String#unpack`
methods in Rubinius.
