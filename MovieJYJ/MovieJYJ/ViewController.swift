//
//  ViewController.swift
//  MovieJYJ
//
//  Created by 소프트웨어컴퓨터 on 2022/05/25.
//

import UIKit
let name = ["qqq","www","eee","rrr","ttt"]

struct MovieData : Codable {
    
    let  boxOfficeResult : BoxOfficeResult
    
}

struct  BoxOfficeResult : Codable {
    
    let  dailyBoxOfficeList : [DailyBoxOfficeList]
    
}

struct  DailyBoxOfficeList : Codable {
    
    let  movieNm : String
    let  audiCnt : String
    let  audiAcc : String
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
   
    var movieData : MovieData?
    var movieURL =
        "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=56b601294f5ded84a7d2b5c39e69a1c3&targetDt=" //20220514
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        movieURL += makeYesterdayString()
        getData()
    }
    func makeYesterdayString()-> String{
        let y = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let dateF = DateFormatter()
        dateF.dateFormat = "yyyyMMdd"
        let day = dateF.string(from: y)
        return day
    }
    func getData(){
        guard let url = URL(string: movieURL) else { return }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                guard let JSONdata = data else { return }
                    //print(JSONdata)
                    //print(response!)
                    let dataString = String(data: JSONdata, encoding: .utf8)
                   // print(dataString!)
                
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode(MovieData.self, from: JSONdata)
                       // print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].movieNm)
                      //  print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].audiCnt)
                        self.movieData = decodedData
                        DispatchQueue.main.async {
                            self.table.reloadData()
                        }
                        
                    }catch{
                        print(error)
                    }
            }
            
            task.resume()
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "MyCell",for: indexPath) as!
            MyTableViewCell
        let numF = NumberFormatter()
        numF.numberStyle = .decimal
        
        //cell.movieName.text = name[indexPath.row]//indexPath.description
        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm

        if let aCnt = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiCnt {
            let aCount = Int(aCnt)!
            let result = numF.string(for: aCount)! + "명"
            cell.audiCount.text = "어제:\(result)"
        }
        if let aACC = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiAcc{
            let aCount = Int(aACC)!
            let result = numF.string(for: aCount)! + "명"
            cell.audiAccumulate.text = "누적:\(result)"
        }
//        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiCnt
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.description)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "박스오피스(영화진흥위원회제공:"+makeYesterdayString()+")"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? DetailViewController else {
            return
        }
        let myIndexPath = table.indexPathForSelectedRow!
        let row = myIndexPath.row
        //print(row)
        dest.movieName = (movieData?.boxOfficeResult.dailyBoxOfficeList[row].movieNm)!
        
    }
}
