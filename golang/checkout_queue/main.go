package main

import (
	"bytes"
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	data, err := os.ReadFile("data.txt")
	if err != nil {
		log.Fatalln("File does not exists", err.Error())
	}

	fl, rest, ok := bytes.Cut(data, []byte("\n"))
	if !ok {
		log.Fatalln("Malformed data")
	}

	config := CreateConfig(fl)
	store := NewStore(config)
	store.Populate(rest)
	store.PrintQueueInfo()
	store.ServeCustomers()
}

type Config struct {
	ExpressLines  int
	RegularLines  int
	ExpressItems  int
	TotalCustomer int
}

func CreateConfig(i []byte) *Config {
	var err error
	v := bytes.Fields(i)

	_ExpressLines, err := strconv.Atoi(string(v[0]))
	_RegularLines, err := strconv.Atoi(string(v[1]))
	_ExpressItems, err := strconv.Atoi(string(v[2]))
	_TotalCustomer, err := strconv.Atoi(string(v[3]))

	if err != nil {
		log.Fatalln("Malformed data:", string(i))
	}

	return &Config{
		ExpressLines:  _ExpressLines,
		RegularLines:  _RegularLines,
		ExpressItems:  _ExpressItems,
		TotalCustomer: _TotalCustomer,
	}
}

// Total number of checkout lines.
func (c *Config) TotalLines() int {
	return c.ExpressLines + c.RegularLines
}

type printable interface {
	comparable
	Print() string
}

// A customer with total number of items in cart and an unique identifier.
type Customer struct {
	id          int
	cartSize    int
	timeToServe int
}

func NewCustomer(id int, cs int) *Customer {
	return &Customer{
		id:          id,
		cartSize:    cs,
		timeToServe: 45 + 5*cs, // Store time required to serve the customer.
	}
}

// Check weather all cart items has been processed or not.
// On every request, reduce 1 second from total remaining time
// and check if the customer used all it's time.
func (c *Customer) IsFinished() bool {
	c.timeToServe -= 1
	return c.timeToServe == 0
}

// Dump customer data as formated string.
func (c *Customer) Print() string {
	return fmt.Sprintf("| %2d | %4d | %4d |\n", c.id, c.cartSize, c.timeToServe)
}

// / Create a checkout line of items of type T.
type CheckoutLine[T printable] struct {
	queue    *LinkedQueue[T]
	waitTime int
}

func NewCheckoutLine[T printable]() *CheckoutLine[T] {
	return &CheckoutLine[T]{
		queue:    NewLinkedQueue[T](),
		waitTime: 0,
	}
}

// Get current wait-time required by the queue (in seconds).
// This is the total time to serve all the customer of this queue.
func (cl *CheckoutLine[T]) WaitTime() int {
	return cl.waitTime
}

// Increase the current wait-time of this queue by
// the time required by the newly added customer.
func (cl *CheckoutLine[T]) AddWaitTime(timeToServe int) {
	cl.waitTime += timeToServe
}

func (cl *CheckoutLine[T]) Print() string {
	return cl.queue.Print()
}

type Node[T printable] struct {
	value *T
	next  *Node[T]
}

func NewNode[T printable](v *T, n *Node[T]) *Node[T] {
	return &Node[T]{
		value: v,
		next:  n,
	}
}

type LinkedQueue[T printable] struct {
	front *Node[T]
	rear  *Node[T]
	count int
}

func NewLinkedQueue[T printable]() *LinkedQueue[T] {
	return new(LinkedQueue[T])
}

// Check is queue is empty.
func (q *LinkedQueue[T]) IsEmpty() bool {
	return q.front == nil
}

// Check is queue has elements.
func (q *LinkedQueue[T]) IsNotEmpty() bool {
	return !q.IsEmpty()
}

// Get number of elements in the Queue.
func (q *LinkedQueue[T]) Count() int {
	return q.count
}

// Lookup front of the Queue without removing it.
func (q *LinkedQueue[T]) Peek() *T {
	return q.front.value
}

// Queue an item to the Queue.
// @param value item to be added to the Queue.
func (q *LinkedQueue[T]) Queue(v *T) {
	if q.rear == nil {
		q.rear = NewNode(v, nil)
		q.front = q.rear
	} else {
		q.rear.next = NewNode(v, nil)
		q.rear = q.rear.next
	}
	q.count++
}

// Remove an item from the Queue.
// @throws Exception if queue is empty.
// @return E the item at the front of the Queue.
func (q *LinkedQueue[T]) Dequeue() *T {
	if q.IsEmpty() {
		log.Fatal("[ERROR]: Cannot dequeue, queue is empty.")
	}
	value := q.front.value
	q.front = q.front.next
	if q.front == nil {
		q.rear = nil
	}
	q.count -= 1
	return value
}

func (q *LinkedQueue[T]) Print() string {
	buffer := bytes.NewBufferString("| No | Item | Time |\n| -- | ---- | ---- |\n")
	node := q.front
	for node != nil {
		fmt.Fprint(buffer, (*node.value).Print())
		node = node.next
	}
	return buffer.String()
}

// Implement check-out lines in a grocery store using a queue data-structure.
//
// Attempt to place customer in the best checkout line possible based on total
// number of customers and the number of items in each cart being processed.
type Store struct {
	config        *Config
	timeToEmpty   int
	checkoutLines []*CheckoutLine[*Customer]
}

func NewStore(c *Config) *Store {
	lines := make([]*CheckoutLine[*Customer], c.TotalLines())
	for i := 0; i < c.TotalLines(); i++ {
		lines[i] = NewCheckoutLine[*Customer]()
	}
	return &Store{
		config:        c,
		timeToEmpty:   0,
		checkoutLines: lines,
	}
}

// Read customer and cart information for each customer from data file and
// initialize required checkout lines.
//
// Calculate the optimal time required to serve a customer, and place new
// customer to the check-out line with the cumulative least amount of time in
// front of it (the shortest line).
func (s *Store) Populate(sl []byte) {
	// Find a checkout line with minimum waiting time and add customer to that.
	// If number of items is less than or equal to express limit, allow
	// customer to enter express line, otherwise check for Regular line.
	for i, line := range bytes.Split(sl, []byte("\n")) {
		if len(line) == 0 {
			continue
		}
		if i > s.config.TotalCustomer {
			log.Fatalln("Data and Config mismatch")
		}
		v, err := strconv.Atoi(string(line))
		if err != nil {
			log.Fatalln("Malformed data element:", string(line))
		}
		c := NewCustomer(i+1, v)
		var line int = 0
		if c.cartSize > s.config.ExpressItems {
			line = s.config.ExpressLines
		}
		minServeTime := s.checkoutLines[line].waitTime
		for j := line + 1; j < s.config.TotalLines(); j++ {
			time := s.checkoutLines[j].waitTime
			if time < minServeTime {
				minServeTime = time
				line = j
			}
		}
		s.checkoutLines[line].queue.Queue(&c)
		s.checkoutLines[line].AddWaitTime(c.timeToServe)
		i++
	}
}

// Optimum starting case for all the check-out lines in the store and calculate
// the amount of time it will take for the store to be empty of all customers.
func (s *Store) PrintQueueInfo() {
	s.timeToEmpty = 0
	for i := 0; i < s.config.TotalLines(); i++ {
		line := s.checkoutLines[i]
		if line.waitTime > s.timeToEmpty {
			s.timeToEmpty = line.waitTime
		}
		lt := "Regular"
		if i < s.config.ExpressLines {
			lt = "Express"
		}
		fmt.Printf("Checkout #%d [%s (time: %ds)]\n%s", i+1, lt, line.waitTime, line.Print())
	}
	fmt.Printf("Total time to serve all customers in store: %ds\n", s.timeToEmpty)
}

// Remove customers from each check-out by servicing the customers.
// It will calculate the state of the checkout lines after every second,
// and display state of lines every 30 seconds (simulated).
//
// Once the amount of time has passed required to serve the customer, the
// customer is removed at the start of the Queue.
func (s *Store) ServeCustomers() {
	buffer := bytes.NewBufferString("| Time | ")
	for i := 0; i < s.config.TotalLines(); i++ {
		fmt.Fprintf(buffer, "L#%-2d| ", i+1)
	}
	buffer.WriteString("\n| ---- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |\n")
	// Each iteration equal to 1 second.
	for i := 0; i < s.timeToEmpty; i++ {
		status := s.queueStatus(i)
		if i > 0 && i%30 == 0 {
			fmt.Fprintln(buffer, status)
		}
	}
	// Check for any leftover customer.
	if s.timeToEmpty%30 != 0 {
		fmt.Fprintln(buffer, s.queueStatus(s.timeToEmpty))
	}
	fmt.Print(buffer)
}

// Check the state of all the checkout lines at particular time.
// Lookup all the checkout lines and generate a report for given time.
// Check and remove any customer from the queue if it's done processing
// all the items (or, run out of time...).
//
// @param time when all checkout lines were analyzed.
// @return String state report of all checkout lines.
func (s *Store) queueStatus(time int) string {
	buffer := bytes.NewBufferString(fmt.Sprintf("| %4d |", time))
	for _, line := range s.checkoutLines {
		if line.queue.IsNotEmpty() && (*line.queue.Peek()).IsFinished() {
			line.queue.Dequeue()
		}
		fmt.Fprintf(buffer, "%4d |", line.queue.Count())
	}
	return buffer.String()
}
