# Spark

## 

* SwiftUI 一个简单的网络请求库，`MacOS`， `iPhone`，`iPad`，`tvOS` 和  `watchOS`。

----

## 安装 ( Installation ) 

#### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler


##### GitHub

```swift
dependencies: [
    .package(url: "https://github.com/dream-swp/Spark.git", .upToNextMajor(from: "1.0.1"))
]
```



----

## 使用 ( Use )





####  Request 





``````swift

// Get | POST
        
let sk = Spark.default

let token: Token = .init()

let convertible: RequestConvertible = .init(convert: url, method: .get, encoding: URLEncoding.default).parameters(parameters).headers(headers)

let token: Token = .init()

sk.request(convertible)
    .receive(on: DispatchQueue.main)
    .sink { complete in
        if case .failure(let error) = complete {
            print(error.localizedDescription)
        }
        token.unseal()
    } receiveValue: { data in
        print(data.sk.string)
    }.sk.seal(token)


``````





#### GET 

```swift

let sk = Spark.default

let token: Token = .init()


let convertible: RequestConvertible = .init(convert: SchemeGet.rand, method: .get, encoding: URLEncoding.default).parameters(parameters).headers(headers)

let token: Token = .init()

// Get 
sk.get(in: convertible)
  	.receive(on: DispatchQueue.main)
	.sink { complete in
		if case .failure(let error) = complete {   
            print(error.localizedDescription)
        }
        token.unseal()
	} receiveValue: { data in
		print(data.sk.string)
	}.sk.seal(token)

```

#### POST

```swift

let sk = Spark.default

let token: Token = .init()

let convertible = RequestConvertibleModel<Model>.post { url }.parameters(parameters).headers(headers)

 // POST
sk.post(in: convertible)
    .receive(on: DispatchQueue.main)
    .sink { complete in
        if case .failure(let error) = complete {
            print(error.localizedDescription)
        }
        token.unseal()
    } receiveValue: { model in
        print(model)
    }.sk.seal(token
              
```

----

