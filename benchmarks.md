Warming Up...
Serialize
===
One
---
Time | JSON | MsgPack | msgpack_dart |
-----|------|---------|--------------|
Total | 225 μs (0.225ms) | 664 μs (0.664ms) | 106 μs (0.106ms)
Average | 0.0225 μs (0.000022499999999999998ms) | 0.0664 μs (0.0000664ms) | 0.0106 μs (0.0000106ms)
Longest | 53 μs (0.053ms) | 232 μs (0.232ms) | 57 μs (0.057ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 1 bytes | 1 bytes | 1 bytes
Fastest | msgpack_dart

Five Hundred Thousand
---
Time | JSON | MsgPack | msgpack_dart |
-----|------|---------|--------------|
Total | 278 μs (0.278ms) | 3702 μs (3.702ms) | 912 μs (0.912ms)
Average | 0.0278 μs (0.000027799999999999998ms) | 0.3702 μs (0.0003702ms) | 0.0912 μs (0.00009120000000000001ms)
Longest | 278 μs (0.278ms) | 470 μs (0.47ms) | 849 μs (0.849ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 6 bytes | 5 bytes | 5 bytes
Fastest | JSON

List of Small Integers
---
Time | JSON | MsgPack | msgpack_dart |
-----|------|---------|--------------|
Total | 277 μs (0.277ms) | 720 μs (0.72ms) | 549 μs (0.549ms)
Average | 0.0277 μs (0.0000277ms) | 0.072 μs (0.00007199999999999999ms) | 0.0549 μs (0.0000549ms)
Longest | 146 μs (0.146ms) | 240 μs (0.24ms) | 336 μs (0.336ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 7 bytes | 4 bytes | 4 bytes
Fastest | JSON

Simple Map
---
Time | JSON | MsgPack | msgpack_dart |
-----|------|---------|--------------|
Total | 514 μs (0.514ms) | 642 μs (0.642ms) | 271 μs (0.271ms)
Average | 0.0514 μs (0.0000514ms) | 0.0642 μs (0.00006419999999999999ms) | 0.0271 μs (0.000027099999999999998ms)
Longest | 135 μs (0.135ms) | 130 μs (0.13ms) | 82 μs (0.082ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 17 bytes | 13 bytes | 13 bytes
Fastest | msgpack_dart

5.02817472928
---
Time | JSON | MsgPack | msgpack_dart |
-----|------|---------|--------------|
Total | 328 μs (0.328ms) | 677 μs (0.677ms) | 426 μs (0.426ms)
Average | 0.0328 μs (0.000032800000000000004ms) | 0.0677 μs (0.00006769999999999999ms) | 0.0426 μs (0.0000426ms)
Longest | 273 μs (0.273ms) | 162 μs (0.162ms) | 45 μs (0.045ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 13 bytes | 9 bytes | 9 bytes
Fastest | JSON

Multiple Type Map
---
Time | JSON | MsgPack | msgpack_dart |
-----|------|---------|--------------|
Total | 11884 μs (11.884ms) | 11063 μs (11.063ms) | 10875 μs (10.875ms)
Average | 1.1884 μs (0.0011883999999999998ms) | 1.1063 μs (0.0011063000000000002ms) | 1.0875 μs (0.0010875ms)
Longest | 150 μs (0.15ms) | 223 μs (0.223ms) | 430 μs (0.43ms)
Shortest | 1 μs (0.001ms) | 1 μs (0.001ms) | 1 μs (0.001ms)
Size | 76 bytes | 61 bytes | 61 bytes
Fastest | msgpack_dart

Medium Data
---
Time | JSON | MsgPack | msgpack_dart |
-----|------|---------|--------------|
Total | 119371 μs (119.371ms) | 42721 μs (42.721ms) | 45695 μs (45.695ms)
Average | 11.9371 μs (0.011937099999999999ms) | 4.2721 μs (0.0042721ms) | 4.5695 μs (0.0045695ms)
Longest | 185 μs (0.185ms) | 137 μs (0.137ms) | 527 μs (0.527ms)
Shortest | 11 μs (0.011ms) | 4 μs (0.004ms) | 4 μs (0.004ms)
Size | 902 bytes | 587 bytes | 587 bytes
Fastest | MsgPack2

Deserialize
===
One
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 77 μs (0.077ms) | 37 μs (0.037ms) |0 μs (0.0ms)
Average | 0.0077 μs (0.0000077ms) | 0.0037 μs (0.0000037ms) |0.0 μs (0.0ms)
Longest | 39 μs (0.039ms) | 36 μs (0.036ms) |0 μs (0.0ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | msgpack_dart

Five Hundred Thousand
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 173 μs (0.173ms) | 113 μs (0.113ms) |84 μs (0.084ms)
Average | 0.0173 μs (0.0000173ms) | 0.0113 μs (0.000011299999999999999ms) |0.0084 μs (0.0000084ms)
Longest | 58 μs (0.058ms) | 19 μs (0.019ms) |26 μs (0.026ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | msgpack_dart

List of Small Integers
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 403 μs (0.403ms) | 149 μs (0.149ms) |149 μs (0.149ms)
Average | 0.0403 μs (0.000040300000000000004ms) | 0.0149 μs (0.0000149ms) |0.0149 μs (0.0000149ms)
Longest | 223 μs (0.223ms) | 32 μs (0.032ms) |47 μs (0.047ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | msgpack_dart

Simple Map
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 154 μs (0.154ms) | 475 μs (0.475ms) |802 μs (0.802ms)
Average | 0.0154 μs (0.0000154ms) | 0.0475 μs (0.0000475ms) |0.0802 μs (0.0000802ms)
Longest | 58 μs (0.058ms) | 207 μs (0.207ms) |569 μs (0.569ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | JSON

5.02817472928
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 282 μs (0.282ms) | 47 μs (0.047ms) |39 μs (0.039ms)
Average | 0.0282 μs (0.0000282ms) | 0.0047 μs (0.0000047ms) |0.0039 μs (0.0000039ms)
Longest | 129 μs (0.129ms) | 25 μs (0.025ms) |39 μs (0.039ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | msgpack_dart

Multiple Type Map
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 873 μs (0.873ms) | 10845 μs (10.845ms) |664 μs (0.664ms)
Average | 0.0873 μs (0.00008730000000000001ms) | 1.0845 μs (0.0010845ms) |0.0664 μs (0.0000664ms)
Longest | 242 μs (0.242ms) | 129 μs (0.129ms) |81 μs (0.081ms)
Shortest | 0 μs (0.0ms) | 1 μs (0.001ms) |0 μs (0.0ms)
Fastest | msgpack_dart

Medium Data
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 44220 μs (44.22ms) | 31762 μs (31.762ms) |12274 μs (12.274ms)
Average | 4.422 μs (0.004422ms) | 3.1762 μs (0.0031762ms) |1.2274 μs (0.0012274ms)
Longest | 147 μs (0.147ms) | 167 μs (0.167ms) |128 μs (0.128ms)
Shortest | 4 μs (0.004ms) | 3 μs (0.003ms) |1 μs (0.001ms)
Fastest | msgpack_dart

