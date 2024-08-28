package main
import (
	"fmt"
	"github.com/PuerkitoBio/goquery"
	"strconv"
	"os"
	"regexp"
	"math"
)
var (
	//modeList = []float64{0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,1.25,1.5,2,2.5,3}

	modeList = []float64{0.5,0.6,0.7,0.8,0.9,1,1.25,1.5,2,2.5,3}

	//modeList = []float64{0.5,0.6}

	valMap = map[string][]*valStr{}
	valMapSame = map[string][]*valStr{}
)
type valStr  struct {
	m float64
	s,n int
}

func (v *valStr)compare(_v *valStr) bool {

	return v.m == _v.m && v.s == _v.s && v.n == _v.n
}
func (v *valStr)getT() float64 {
	return getT(v.m,float64(v.s),float64(v.n))
}

//func(v *valStr)getZm()float64{
//	return 
//}
func (v *valStr)getB()float64{
	//return float64(v.s*2+v.n*2)/float64(v.s)
	return float64(v.s+v.n*2)/float64(v.s)
}


func (v *valStr)getBn()float64{
	s_ := float64(v.s)
	n_ := float64(v.n)

	return (s_+n_*2)/n_
	//(s_/n_) *
}

func readDataList( hc func(s,n int)){
	f,err := os.Open("ngwList.html")
	if err != nil {
		panic(err)
	}
	doc,err := goquery.NewDocumentFromReader(f)
	//doc,err := goquery.NewDocument("http://dev.inkcad.com/WebSource/Book/%E6%9C%BA%E6%A2%B0%E5%B7%A5%E7%A8%8B%E5%B8%88%E8%AE%BE%E8%AE%A1%E6%89%8B%E5%86%8C/Gallery/NEW14/14438-3.htm")
	if err != nil {
		panic(err)
	}
	doc.Find("tr").Each(func(i int,s *goquery.Selection){

		list_val := make([]int, 0 , 20)
		s.Find("td p").Each(func(_i int,_s *goquery.Selection){
			_s.Find("span").Each(func(__i int,__s *goquery.Selection){
				//val := s.Text()
				val := regexp.MustCompile(`\s`).ReplaceAllString(__s.Text(),"")
				//if val =="" {
				//	return
				//}
				//fmt.Printf("%s ",val)
				//t,err := strconv.ParseFloat(val,64)
				t,err := strconv.Atoi(val)
				if err != nil {
					//fmt.Println(val,err)
					return
				}
				//fmt.Println(t)
				list_val = append(list_val,t)
	
				return
			})
		})
		lenV := len(list_val)	
		if lenV%5 != 0 {
			return
		}
		for j:=0;j<lenV;j+=5{
			//fmt.Println(list_val[j:2])
			hc(list_val[j],list_val[j+1])
		}
	})
}
func main(){
	readDataList(func(s,n int){
		if (s+(s+n*2))%3 != 0 {
			return
		}
	
		getMode(func(m float64){
				//T := getT(m,float64(s),float64(n))
				setValMap(3,s,n,getT(m,float64(s),float64(n)),m)
		})
	})
}


func checkVal(v,_v *valStr,k string)  {
	//_r :=float64( _v.n*2 + _v.s)

	//r := float64(v.n*2 + v.s)
	//zvl:= float64(r) *v.m
	//if zvl > 60 {
	//	return
	//}

	//if v.s< v.n {
	//	return
	//}

	bn__v := v.getB()
	vsn := math.Abs(float64(v.n)/float64(v.s))

	_vnr := float64( _v.n*2 + _v.s)/float64(_v.n)
	endV:= vsn*_vnr 
	endVal := int(10000/math.Abs(10000/bn__v-10000/endV))

	if endVal>200 && endVal<550 {
		fmt.Println(v,_v,k,endVal)
	}


	//if v.getT() != _v.getT() {
	//	return
	//}
	//if float64(v.s + v.n*2) *v.m >= float64(_v.s + _v.n*2) *_v.m {
	//	return
	//}
	//t := float64(v.n)/float64(v.s)
	//if t>2 {
	//	return
	//}
	//bn_v := t*_v.getBn()
	//if bn_v<1 {
	//	return
	//}
	//bn_ :=10000/ bn_v

//	vn:= vl/float64(v.n)
//	_vn:= _vl/float64(_v.n)
//	bn__v := v.getB()
//	bn:= 10000/  bn__v
//	bn_ := bn*vn /_vn
//	bnn := math.Abs(bn-bn_)
//	//if bnn< bn && bnn <bn_ && bnn<100 {
//	if bnn>10 && bn*vn< 8000 {
//	//if bnn>10 && zvl< 10 {
//		fmt.Printf("%.2f,%.2f",bnn,bn__v)
//		fmt.Printf(" %.2f,%.02f",bn*vn,bn_)
//		fmt.Printf(" %.2f,%.02f",vn,_vn)
//		fmt.Println(v,_v,k)
//	}

}

//func checkVal_(v,_v,__v *valStr)  {
//
//	if float64(__v.s)*__v.m  < float64(_v.s+2*_v.n) * _v.m {
//		return
//	}
//	t := float64(v.n)/float64(v.s)
//	//if t>2 {
//	//	return
//	//}
//	bn:= v.getB() * t *_v.getBn()*__v.getB()
//	//if bn < 200 && bn > 150 {
//		fmt.Println(v,_v,__v,int(bn))
//	//}
//
//}

func setValMap(tn,s,n int,T,m float64){

	if T > 20 {
		return
	}

	k := fmt.Sprintf("%d_%.2f",tn,T)
	val := valMap[k]
	//v := fmt.Sprintf("%.1f_%d_%d",m,s,n)
	v := &valStr{m:m,s:s,n:n}
	if val == nil {
		valMap[k] = []*valStr{v}
		return
	}

	//b := v.getB() * (float64(v.n)/float64(v.s))
	//bn := v.getBn()
	//checkVal(v,v,k)
	isHave :=  false
	for _,_v := range val {
		// isHave = _v.compare(v)
		if _v.compare(v) {
			if !isHave {
				isHave = true
			}
			continue
		}

		checkVal(v,_v,k)
		checkVal(_v,v,k)

		//for _,__v := range val {
		//	//if _v == __v {
		//	//	continue
		//	//}
		//	checkVal(v,_v,__v)
		//	checkVal(v,__v,_v)
		//	checkVal(_v,v,__v)
		//	checkVal(_v,__v,v)
		//	checkVal(__v,v,_v)
		//	checkVal(__v,_v,v)
		//}
	}
	//val =  append(val,v)
	if !isHave {
		valMap[k] = append(val,v)
	}

}
func getNum(sun int,planet int)( int){
	return planet*2 + sun*2
	//num_planet = 0
	//if Tx%3 == 0 {
	//	num_planet =1
	//}
	//if Tx%4 == 0 {
	//	num_planet |=(1<<1)
	//}
	//if Tx%5 == 0 {
	//	num_planet |=(1<<2)
	//}
	//return


}
func getT(mode float64,sun float64,planet float64)float64{

	return (planet/2+ sun/2 )*mode
	
}
func getMode(hc func(float64)){

	for _,m := range modeList{
		hc(m)
	}
}
//func getPlanet(index int, hc func(int)){
//	if index<6 {
//		index = 6
//	}
//
//	for n :=index;n<=100;n++{
//		hc(n)
//	}
//}
