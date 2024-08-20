package main

import (
	"bytes"
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
	"strings"
	"time"
)

// Working with single and multidimensional arrays.
//
// Solve 4 problems as:
// 1) Find the lowest elevation value and number of times it occurs in dataset.
// 2) Find all the local peaks matching given criteria. (Incomplete).
// 3) Find the two closest peaks in the dataset.
// 4) Find the most common elevation and number of times it occurs.
func main() {
	c := configFromFile("data.txt")

	st := time.Now().UnixMilli()

	mev, mec := problem1(c.Data)
	lp := problem2(c, c.Data)
	cp1, cp2 := problem3(*lp)
	mchk, mchv := problem4(c.Data)

	et := time.Now().UnixMilli()

	fmt.Printf("> Total execution time: %d ms.\n", et-st)
	fmt.Printf("> Lowest elevation: %d, and it occurs: %d times.\n", mev, mec)
	fmt.Printf("> Total # of peaks: %d.\n", len(*lp))
	fmt.Printf("> Closest peaks distance: %.2f m, this occurs at: %s and %s\n", cp1.DistanceTo(cp2), cp1.Print(), cp2.Print())
	fmt.Printf("> Most common height: %d, this occurs: %d times.\n", mchk, mchv)
}

func configFromFile(p string) *Config {
	f, err := os.ReadFile(p)
	if err != nil {
		log.Fatalf("Unable to open file: %s", err.Error())
	}

	fl, rest, ok := bytes.Cut(f, []byte("\n"))
	if !ok {
		log.Fatal("Unable to split first line")
	}

	c, err := CreateConfig(fl)
	l := bytes.Split(rest, []byte("\n"))

	// Create array of size [ROWS] times [COLS].
	for i := 0; i < c.Rows; i++ {
		fl := bytes.Fields(l[i])
		for j := 0; j < c.Cols; j++ {
			v, err := strconv.Atoi(string(fl[j]))
			if err != nil {
				log.Fatalf("Unable to convert element: %s", err.Error())
			}
			c.Data[i][j] = v
		}
	}

	return c
}

type Config struct {
	Rows  int     // Number of rows in dataset
	Cols  int     // Number of columns in dataset
	MinP  int     // Minimum peak value
	ExRad int     // The exclusion radius
	Data  [][]int // Elevation data grid
}

func CreateConfig(b []byte) (*Config, error) {
	v := strings.Fields(string(b))
	if len(v) != 4 {
		return nil, fmt.Errorf("Malformed data %s", v)
	}

	rw, _ := strconv.Atoi(v[0])
	cl, _ := strconv.Atoi(v[1])
	mp, _ := strconv.Atoi(v[2])
	er, _ := strconv.Atoi(v[3])

	d := make([][]int, rw)
	for i := range rw {
		d[i] = make([]int, cl)
	}

	return &Config{
		Rows:  rw,
		Cols:  cl,
		MinP:  mp,
		ExRad: er,
		Data:  d,
	}, nil
}

// An elevation with value and location.
// Initialize new Peak(elevation) object.
//
// @param i - Index of the Row in dataset.
// @param j - Index of the Column in dataset.
// @param v - Peak (elevation) value at above Row and Column index.
type Peak struct {
	i int
	j int
	v int
}

// Compare the two elevation by its location and find the distance.
// Formula: Distance^2 = E1(Row) - E2(Row)^2 + E1(Column) - E2(Column)^2
// where, E1 = first peak (initial), E2 = second peak (other).
//
// @param other accepts a Peak object to compare with.
// @return double distance value between two peaks.
func (p *Peak) DistanceTo(o *Peak) float64 {
	return math.Sqrt(math.Pow(float64(p.i-o.i), 2.0) + math.Pow(float64(p.j-o.j), 2.0))
}

func (p *Peak) Print() string {
	return fmt.Sprintf("[(%d, %d): %d]", p.i, p.j, p.v)
}

// Find the lowest elevation and number of time it occurs in the dataset.
//
// @param data two-dimensional array to find minimum elevation.
// @return Int array with two elements of minimum elevation and its count.
func problem1(data [][]int) (mev int, mec int) {
	mev, mec = data[0][0], 0

	for _, iv := range data {
		for _, jv := range iv {
			// Reset counter if new minimum found, increase otherwise.
			if jv < mev {
				mev, mec = jv, 0
			}
			if jv == mev {
				mec++
			}
		}
	}

	// Lowest elevation: `20119`, and it occurs: `4` times.
	return
}

// Find all the local peaks that is grater then or equal to
// value [Config.minPeak], and that is not contained
// in the given exclusion radius [Config.exRadius].
//
// @param data two-dimensional array containing the data.
// @return an array of [Peak]s, found in the dataset.
// [Peak] is a class containing elevation value and its location.
//
// This implementation Incomplete / Inaccurate.
func problem2(c *Config, d [][]int) *[]Peak {
	l := make([]Peak, 0)

	// A fix sized block in the dataset to look for peaks.
	ws := c.ExRad*2 + 1

	for i := 0; i < c.Rows-ws; i++ {
		for j := 0; j < c.Cols-ws; j++ {
			v := d[i][j]

			// Find the max value within the block,
			// i.e. `block = radius + 1 + radius`.
			p := Peak{i: i, j: j, v: v}
			for m := i; m < ws-1+i; m++ {
				for n := j; n < ws-1+j; n++ {
					if d[m][n] > p.v {
						p = Peak{i: m, j: n, v: d[m][n]}
					}
				}
			}

			// Check if the above max value is within the radius range,
			// and value is greater then or equal to minimum peak.
			if p.v >= c.MinP &&
				p.v == d[i+c.ExRad][j+c.ExRad] {
				l = append(l, p)
			}
		}
	}

	return &l
}

// Find the two closest peaks, from the dataset.
//
// @param peaks an array of local peaks found in problem #2.
// @return an array of peaks, containing two closest local peaks.
func problem3(pl []Peak) (p1 *Peak, p2 *Peak) {
	// Find the distance between two peaks.
	md := pl[0].DistanceTo(&pl[1])

	// Find the minimim distance by comparing every single pair of Peak
	// to the next Peak.
	for i := 2; i < len(pl)-1; i++ {
		d := pl[i].DistanceTo(&pl[i+1])
		if d < md {
			md = d
			p1, p2 = &pl[i], &pl[i+1]
		}
	}

	return
}

// Most common height (elevation) and number of times it occurs in the dataset.
// @param data two-dimensional array containing the dataset.
// @return Pair with most common height and its count.
func problem4(d [][]int) (k int, v int) {
	// Hold maximum possible value as an index from the dataset.
	ecm := make(map[int]int) // 112000;

	// Use dataset value as an index to the array and find its count.
	for _, iv := range d {
		for _, jv := range iv {
			if v, ok := ecm[jv]; ok {
				ecm[jv] = v + 1
			} else {
				ecm[jv] = 1
			}
		}
	}

	k, v = -1, -1
	// Find the maximum count (value) and its assosiated index (elevation).
	for ek, ev := range ecm {
		if v < ev {
			k, v = ek, ev
		}
	}

	return
}
