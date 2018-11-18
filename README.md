This is the open source benchmark for https://pspdfkit.com/blog/2018/ios-heic-performance/

[![](https://pspdfkit.com/images/blog/2018/ios-heic-performance/article-header-2a327dfe.png)](https://pspdfkit.com/blog/2018/ios-heic-performance/)

This benchmark includes both our own code, and benchmarking code from Costantino Pistagna ("third party benchmark").

## Results

### iPad Pro 11' (2018 Model, A12X chip)

```
Encoding JPEG 1.00 took 8.064s
Encoding JPEG 0.90 took 4.345s
Encoding HEIC 1.00 took 10.326s
Encoding HEIC 0.90 took 9.896s
Decoding JPEG 1.00 took 2.397s
Decoding JPEG 0.90 took 2.084s
Decoding HEIC 1.00 took 12.990s
Decoding HEIC 0.90 took 12.

Performing third party benchmark...
Encoding HEIC 1.0 took 10.279 seconds to complete.
Encoding HEIC 0.9 took 9.934 seconds to complete.
Encoding JPEG 1.0 took 8.118 seconds to complete.
Encoding JPEG 0.9 took 4.432 seconds to complete.
Decoding HEIC 1.0 took 13.060 seconds to complete.
Decoding JPEG 1.0 took 2.155 seconds to complete.
Decoding HEIC 0.9 took 12.127 seconds to complete.
Decoding JPEG 0.9 took 1.983 seconds to complete.
```

### iPhone XS Max (2018 Model, A12 chip)

```
Encoding JPEG 1.00 took 8.848s
Encoding JPEG 0.90 took 4.802s
Encoding HEIC 1.00 took 9.117s
Encoding HEIC 0.90 took 8.823s
Decoding JPEG 1.00 took 2.263s
Decoding JPEG 0.90 took 1.962s
Decoding HEIC 1.00 took 11.612s
Decoding HEIC 0.90 took 10.263s

Performing third party benchmark...
Encoding HEIC 1.0 took 9.497 seconds to complete.
Encoding HEIC 0.9 took 9.035 seconds to complete.
Encoding JPEG 1.0 took 8.521 seconds to complete.
Encoding JPEG 0.9 took 4.385 seconds to complete.
Decoding HEIC 1.0 took 11.537 seconds to complete.
Decoding JPEG 1.0 took 2.212 seconds to complete.
Decoding HEIC 0.9 took 11.493 seconds to complete.
Decoding JPEG 0.9 took 1.985 seconds to complete.
```

### Benchmark Considerations

Comparing 0.9 of one compression algorithm with 0.9 of another is comparing apples and oranges. You want to pick _some_ numbers A and B at which the output has a comparable quality look. E.g. 0.9 for Apple’s JPEG might be equivalent to 0.8 for their HEIF. - [Daniel Eggert](https://twitter.com/danielboedewadt/status/1062862148500512768)

### License

MIT, see LICENSE file.

### Special Thanks

Costantino Pistagna, sofapps for https://gist.github.com/valvoline/428cdd5a409cd7c7946a93d76bacc330

