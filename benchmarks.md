Warming Up...
Serialize
===
One
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 464 μs (0.464ms) | 521 μs (0.521ms) |81 μs (0.081ms)
Average | 0.0464 μs (0.000046399999999999996ms) | 0.0521 μs (0.0000521ms) |0.0081 μs (0.0000081ms)
Longest | 79 μs (0.079ms) | 156 μs (0.156ms) |35 μs (0.035ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Size | 1 bytes | 1 bytes | 1 bytes
Fastest | msgpack_dart

Five Hundred Thousand
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 983 μs (0.983ms) | 10792 μs (10.792ms) |148 μs (0.148ms)
Average | 0.0983 μs (0.0000983ms) | 1.0792 μs (0.0010792ms) |0.0148 μs (0.0000148ms)
Longest | 310 μs (0.31ms) | 1125 μs (1.125ms) |19 μs (0.019ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Size | 6 bytes | 5 bytes | 5 bytes
Fastest | msgpack_dart

List of Small Integers
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 271 μs (0.271ms) | 1048 μs (1.048ms) |1 μs (0.001ms)
Average | 0.0271 μs (0.000027099999999999998ms) | 0.1048 μs (0.0001048ms) |0.0001 μs (1.0000000000000001e-7ms)
Longest | 158 μs (0.158ms) | 585 μs (0.585ms) |1 μs (0.001ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Size | 7 bytes | 4 bytes | 4 bytes
Fastest | msgpack_dart

Simple Map
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 550 μs (0.55ms) | 541 μs (0.541ms) |167 μs (0.167ms)
Average | 0.055 μs (0.000055ms) | 0.0541 μs (0.0000541ms) |0.0167 μs (0.0000167ms)
Longest | 68 μs (0.068ms) | 181 μs (0.181ms) |41 μs (0.041ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Size | 17 bytes | 13 bytes | 13 bytes
Fastest | msgpack_dart

5.02817472928
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 0 μs (0.0ms) | 444 μs (0.444ms) |0 μs (0.0ms)
Average | 0.0 μs (0.0ms) | 0.0444 μs (0.0000444ms) |0.0 μs (0.0ms)
Longest | 0 μs (0.0ms) | 159 μs (0.159ms) |0 μs (0.0ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Size | 13 bytes | 9 bytes | 9 bytes
Fastest | msgpack_dart

Multiple Type Map
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 10531 μs (10.531ms) | 11024 μs (11.024ms) |10884 μs (10.884ms)
Average | 1.0531 μs (0.0010531ms) | 1.1024 μs (0.0011024000000000001ms) |1.0884 μs (0.0010884ms)
Longest | 162 μs (0.162ms) | 100 μs (0.1ms) |62 μs (0.062ms)
Shortest | 1 μs (0.001ms) | 1 μs (0.001ms) |1 μs (0.001ms)
Size | 76 bytes | 61 bytes | 61 bytes
Fastest | JSON

Medium Data
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 114502 μs (114.502ms) | 44948 μs (44.948ms) |45542 μs (45.542ms)
Average | 11.4502 μs (0.0114502ms) | 4.4948 μs (0.004494799999999999ms) |4.5542 μs (0.0045542ms)
Longest | 363 μs (0.363ms) | 293 μs (0.293ms) |167 μs (0.167ms)
Shortest | 11 μs (0.011ms) | 4 μs (0.004ms) |4 μs (0.004ms)
Size | 902 bytes | 587 bytes | 587 bytes
Fastest | MsgPack2

Deserialize
===
One
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 5736 μs (5.736ms) | 6 μs (0.006ms) |153 μs (0.153ms)
Average | 0.5736 μs (0.0005736ms) | 0.0006 μs (6e-7ms) |0.0153 μs (0.0000153ms)
Longest | 1512 μs (1.512ms) | 4 μs (0.004ms) |93 μs (0.093ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | MsgPack2

Five Hundred Thousand
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 273 μs (0.273ms) | 1625 μs (1.625ms) |678 μs (0.678ms)
Average | 0.0273 μs (0.000027300000000000003ms) | 0.1625 μs (0.0001625ms) |0.0678 μs (0.0000678ms)
Longest | 226 μs (0.226ms) | 792 μs (0.792ms) |391 μs (0.391ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | JSON

List of Small Integers
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 5816 μs (5.816ms) | 1165 μs (1.165ms) |482 μs (0.482ms)
Average | 0.5816 μs (0.0005816ms) | 0.1165 μs (0.00011650000000000001ms) |0.0482 μs (0.0000482ms)
Longest | 429 μs (0.429ms) | 541 μs (0.541ms) |111 μs (0.111ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | msgpack_dart

Simple Map
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 9 μs (0.009ms) | 57 μs (0.057ms) |131 μs (0.131ms)
Average | 0.0009 μs (9e-7ms) | 0.0057 μs (0.0000057000000000000005ms) |0.0131 μs (0.0000131ms)
Longest | 8 μs (0.008ms) | 48 μs (0.048ms) |55 μs (0.055ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | JSON

5.02817472928
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 3815 μs (3.815ms) | 647 μs (0.647ms) |191 μs (0.191ms)
Average | 0.3815 μs (0.0003815ms) | 0.0647 μs (0.00006469999999999999ms) |0.0191 μs (0.0000191ms)
Longest | 1123 μs (1.123ms) | 426 μs (0.426ms) |88 μs (0.088ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | msgpack_dart

Multiple Type Map
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 7252 μs (7.252ms) | 6808 μs (6.808ms) |906 μs (0.906ms)
Average | 0.7252 μs (0.0007252ms) | 0.6808 μs (0.0006808ms) |0.0906 μs (0.0000906ms)
Longest | 215 μs (0.215ms) | 71 μs (0.071ms) |49 μs (0.049ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | msgpack_dart

Medium Data
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 53602 μs (53.602ms) | 34292 μs (34.292ms) |17180 μs (17.18ms)
Average | 5.3602 μs (0.0053602ms) | 3.4292 μs (0.0034292ms) |1.718 μs (0.001718ms)
Longest | 170 μs (0.17ms) | 178 μs (0.178ms) |765 μs (0.765ms)
Shortest | 4 μs (0.004ms) | 3 μs (0.003ms) |1 μs (0.001ms)
Fastest | msgpack_dart

