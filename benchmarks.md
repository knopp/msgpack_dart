Warming Up...
Serialize
===
One
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 257 μs (0.257ms) | 634 μs (0.634ms) | 135 μs (0.135ms)
Average | 0.0257 μs (0.0000257ms) | 0.0634 μs (0.0000634ms) | 0.0135 μs (0.0000135ms)
Longest | 111 μs (0.111ms) | 161 μs (0.161ms) | 47 μs (0.047ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 1 bytes | 1 bytes | 1 bytes
Fastest | msgpack_dart

Five Hundred Thousand
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 855 μs (0.855ms) | 12086 μs (12.086ms) | 204 μs (0.204ms)
Average | 0.0855 μs (0.0000855ms) | 1.2086 μs (0.0012086ms) | 0.0204 μs (0.0000204ms)
Longest | 644 μs (0.644ms) | 1222 μs (1.222ms) | 20 μs (0.02ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 6 bytes | 5 bytes | 5 bytes
Fastest | msgpack_dart

List of Small Integers
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 264 μs (0.264ms) | 561 μs (0.561ms) | 234 μs (0.234ms)
Average | 0.0264 μs (0.0000264ms) | 0.0561 μs (0.000056099999999999995ms) | 0.0234 μs (0.0000234ms)
Longest | 69 μs (0.069ms) | 145 μs (0.145ms) | 31 μs (0.031ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 7 bytes | 4 bytes | 4 bytes
Fastest | msgpack_dart

Simple Map
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 195 μs (0.195ms) | 1012 μs (1.012ms) | 101 μs (0.101ms)
Average | 0.0195 μs (0.0000195ms) | 0.1012 μs (0.0001012ms) | 0.0101 μs (0.0000101ms)
Longest | 73 μs (0.073ms) | 480 μs (0.48ms) | 43 μs (0.043ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 17 bytes | 13 bytes | 13 bytes
Fastest | msgpack_dart

5.02817472928
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 0 μs (0.0ms) | 427 μs (0.427ms) | 0 μs (0.0ms)
Average | 0.0 μs (0.0ms) | 0.0427 μs (0.0000427ms) | 0.0 μs (0.0ms)
Longest | 0 μs (0.0ms) | 203 μs (0.203ms) | 0 μs (0.0ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) | 0 μs (0.0ms)
Size | 13 bytes | 9 bytes | 9 bytes
Fastest | msgpack_dart

Multiple Type Map
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 11567 μs (11.567ms) | 10959 μs (10.959ms) | 10804 μs (10.804ms)
Average | 1.1567 μs (0.0011567ms) | 1.0959 μs (0.0010959000000000001ms) | 1.0804 μs (0.0010804ms)
Longest | 423 μs (0.423ms) | 448 μs (0.448ms) | 52 μs (0.052ms)
Shortest | 1 μs (0.001ms) | 1 μs (0.001ms) | 1 μs (0.001ms)
Size | 76 bytes | 61 bytes | 61 bytes
Fastest | msgpack_dart

Medium Data
---
Time | JSON | MsgPack | New MsgPack | msgpack_dart |
-----|------|---------|-------------|--------------|
Total | 122652 μs (122.652ms) | 41877 μs (41.877ms) | 46685 μs (46.685ms)
Average | 12.2652 μs (0.0122652ms) | 4.1877 μs (0.004187700000000001ms) | 4.6685 μs (0.0046685ms)
Longest | 212 μs (0.212ms) | 104 μs (0.104ms) | 167 μs (0.167ms)
Shortest | 11 μs (0.011ms) | 4 μs (0.004ms) | 4 μs (0.004ms)
Size | 902 bytes | 587 bytes | 587 bytes
Fastest | MsgPack2

Deserialize
===
One
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 5218 μs (5.218ms) | 39 μs (0.039ms) |229 μs (0.229ms)
Average | 0.5218 μs (0.0005218ms) | 0.0039 μs (0.0000039ms) |0.0229 μs (0.0000229ms)
Longest | 1510 μs (1.51ms) | 19 μs (0.019ms) |111 μs (0.111ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | MsgPack2

Five Hundred Thousand
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 485 μs (0.485ms) | 2044 μs (2.044ms) |827 μs (0.827ms)
Average | 0.0485 μs (0.0000485ms) | 0.2044 μs (0.0002044ms) |0.0827 μs (0.00008269999999999999ms)
Longest | 319 μs (0.319ms) | 856 μs (0.856ms) |270 μs (0.27ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | JSON

List of Small Integers
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 7013 μs (7.013ms) | 1309 μs (1.309ms) |603 μs (0.603ms)
Average | 0.7013 μs (0.0007013000000000001ms) | 0.1309 μs (0.00013089999999999998ms) |0.0603 μs (0.0000603ms)
Longest | 323 μs (0.323ms) | 516 μs (0.516ms) |170 μs (0.17ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | msgpack_dart

Simple Map
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 775 μs (0.775ms) | 887 μs (0.887ms) |828 μs (0.828ms)
Average | 0.0775 μs (0.0000775ms) | 0.0887 μs (0.0000887ms) |0.0828 μs (0.0000828ms)
Longest | 37 μs (0.037ms) | 94 μs (0.094ms) |66 μs (0.066ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | JSON

5.02817472928
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 6816 μs (6.816ms) | 1737 μs (1.737ms) |393 μs (0.393ms)
Average | 0.6816 μs (0.0006816ms) | 0.1737 μs (0.0001737ms) |0.0393 μs (0.0000393ms)
Longest | 1943 μs (1.943ms) | 460 μs (0.46ms) |125 μs (0.125ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | msgpack_dart

Multiple Type Map
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 6728 μs (6.728ms) | 8954 μs (8.954ms) |1721 μs (1.721ms)
Average | 0.6728 μs (0.0006728ms) | 0.8954 μs (0.0008954ms) |0.1721 μs (0.0001721ms)
Longest | 318 μs (0.318ms) | 67 μs (0.067ms) |63 μs (0.063ms)
Shortest | 0 μs (0.0ms) | 0 μs (0.0ms) |0 μs (0.0ms)
Fastest | msgpack_dart

Medium Data
---
Time | JSON | MsgPack2 | msgpack_dart |
-----|------|----------|--------------|
Total | 56457 μs (56.457ms) | 34942 μs (34.942ms) |25224 μs (25.224ms)
Average | 5.6457 μs (0.0056457ms) | 3.4942 μs (0.0034942000000000003ms) |2.5224 μs (0.0025224ms)
Longest | 196 μs (0.196ms) | 179 μs (0.179ms) |815 μs (0.815ms)
Shortest | 4 μs (0.004ms) | 3 μs (0.003ms) |1 μs (0.001ms)
Fastest | msgpack_dart

