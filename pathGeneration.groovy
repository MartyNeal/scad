class LibraryTest {

    List<List<Integer>> topRight = [[70, 0], [40, 17.5], [30.2479, 31.9681], [22.0137, 45.7968], [15.2408, 58.9696], [9.87246, 71.4704], [5.85202, 83.283], [3.12279, 94.3911], [1.62807, 104.778], [1.31119, 114.429]]
    List<List<Integer>> topLeft = [[1.31119, 114.429], [2.11544, 123.326], [3.98416, 131.454], [6.86064, 138.796], [10.6882, 145.336], [15.4102, 151.058], [20.9698, 155.946], [27.3105, 159.983], [34.3756, 163.153], [42.1082, 165.44], [50.4519, 166.827], [59.3498, 167.299], [68.7453, 166.84], [78.5817, 165.432], [88.8023, 163.06], [99.3504, 159.707], [110.169, 155.358], [121.203, 149.995], [132.393, 143.603], [143.684, 136.166], [155.02, 127.667], [166.343, 118.09], [177.596, 107.419], [188.724, 95.6375], [199.669, 82.7292], [210.374, 68.678], [220.784, 53.4677], [230.841, 37.0819], [240.488, 19.5045], [249.67, 0.71916]]
    List<List<Integer>> topLine = topRight[0..-2] + topLeft
    List<List<Integer>> bottomLine = [[0, 265], [0.431534, 260.079], [1.70268, 255.649], [3.77823, 251.661], [6.62301, 248.063], [10.2018, 244.804], [14.4794, 241.835], [19.4207, 239.104], [24.9904, 236.561], [31.1534, 234.155], [37.8745, 231.835], [45.1184, 229.551], [52.85, 227.252], [61.034, 224.887], [69.6354, 222.406], [78.6188, 219.759], [87.9492, 216.893], [97.5912, 213.76], [107.51, 210.307], [117.67, 206.485], [128.036, 202.243], [138.573, 197.53], [149.245, 192.295], [160.019, 186.488], [170.857, 180.058], [181.726, 172.955], [192.59, 165.127], [203.413, 156.525], [214.161, 147.097], [224.799, 136.792], [235.291, 125.561], [245.601, 113.352], [255.696, 100.115], [265.539, 85.7995], [275.095, 70.3541], [284.33, 53.7285], [293.208, 35.8721], [301.694, 16.7341], [302, 269]]

    static double dist(List<Integer> p1, List<Integer> p2) {
        Math.sqrt((p1[0]-p2[0])**2 + (p1[1]-p2[1])**2)
    }

    def findMinDistance() {
        def min = Double.MAX_VALUE
        def bestT = null
        def bestB = null

        for (List<Integer> t in topLine) {
            for (List<Integer> b in bottomLine) {
                if (dist(t,b) < min) {
                    min = dist(t,b)
                    bestT = t
                    bestB = b
                }
            }
        }

        [min, bestT, bestB]
    }

    def bottomSlopes = makeSlopes(bottomLine.reverse())
    def topRightSlopes = makeSlopes(topRight)
    def topLeftSlopes = makeSlopes(topLeft.reverse())

    static def makeSlopes(List<List<Integer>> line)
    {
        (0..<(line.size() - 1)).collect { i ->
            def p1 = line[i]
            def p2 = line[i+1]
            def (x1, y1) = p1
            def (x2, y2) = p2
            def m = (y2-y1) / (x2-x1)
            def b = y1 - m * x1
            [x1, m, b]
        }
    }

    def maxXbottomLine = bottomLine*.get(0).max()
    def maxYbottomLine = bottomLine*.get(1).max()
    def minXbottomLine = bottomLine*.get(0).min()
    def maxXtopRightLine = topRight*.get(0).max()
    def minXtopRightLine = topRight*.get(0).min()
    def maxXtopLeftLine = topLeft*.get(0).max()
    def minXtopLeftLine = topLeft*.get(0).min()
    def triange = [70, -7/12, 490/12]
    def rightSide = -50
    def boundsCheck(p1, p2) {
        def (x1, y1) = p1
        def (x2, y2) = p2
        def (minX, maxX) = x1 < x2 ? [x1, x2] : [x2, x1]
        def (minY, maxY) = y1 < y2 ? [y1, y2] : [y2, y1]
        if (minY < 0 ||
            maxY > maxYbottomLine ||
            maxX > maxXbottomLine ||
            minX < rightSide) return false

//        if (maxX > minXbottomLine) {
//            def (_, m, b) = bottomSlopes.takeWhile { it[0] > maxX ? it : null }[-1]
//            if (m * maxX + b < maxY) {
//                return false
//            }
//        }

        //if (triange[1] * minX + triange[2] > minY)
        //    return false

        return true
    }

    static def rand = new Random(4)


    static def blockSizess() { [ *([[8, 16]]*1),*([[16,16]]*0) ].collectMany { [it, [it[1], it[0]]].unique() } }

    static void main(String[] args) {
        def l = new LibraryTest()
        //println l.findMinDistance()
        def gcd = 8
        def laidBlocks = []
        new File("/Src/scad/path.scad").withPrintWriter { writer ->
            for (def prevY = l.maxYbottomLine; prevY > 0; prevY -= gcd) {
                for (def prevX = l.rightSide; l.boundsCheck([gcd + prevX, prevY], [prevX, prevY - gcd]); prevX += gcd) {
                    def remainingBlockSizes = blockSizess()
                    while (remainingBlockSizes) {
                        def block = pickBlock(remainingBlockSizes)
                        if (l.boundsCheck([block[0] + prevX, prevY], [prevX, prevY - block[1]]) && !laidBlocks.any { overlaps(it[0], it[1], [prevX, prevY], block) } ) {
                            laidBlocks << [[prevX, prevY], block]
                            writer.println("color(redish()) translate(" + [prevX, prevY - block[1]] + ") cube(" + (block + [1]) + ");")
                            prevX += block[0] - gcd
                            break
                        }

                        remainingBlockSizes.pop();
                    }
                }
            }
        }
        println laidBlocks
    }

    static def pickBlock(blockSizes) {
        blockSizes[rand.nextInt(blockSizes.size())]
    }

    static def offsetBlock(block, offset) {
        [[block[0] + offset[0], block[1]], [offset[1] - block[1]]]
    }

    //block 1 is lower
    static def overlaps(offset1, block1, offset2, block2) {
        (
            (
                (offset1[0] <= offset2[0] && offset2[0] < offset1[0] + block1[0]) ||
                    (offset1[0] < offset2[0] + block2[0] && offset2[0] + block2[0] <= offset1[0] + block1[0])
            ) && (
                offset1[1]-block1[1] < offset2[1] && offset2[1] < offset1[1] ||
                    offset1[1]-block1[1] < offset2[1] - block2[1] && offset2[1] - block2[1] < offset1[1]
            )
        )
    }

    static int gcd(int a, int b) {
        !a ? b : gcd(b % a, a);
    }
}

