//
//  ContentView.swift
//  UI-79
//
//  Created by にゃんにゃん丸 on 2020/12/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    @State var value : CGFloat = 0.5
    var body: some View{
        
        VStack{
            
            Text("Conversation")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.top,40)
            
            
            
            Spacer()
            
            HStack{
                
                ForEach(1...4,id:\.self){_ in
                    
                    ZStack{
                        
                        
                        Eyes()
                            .stroke(Color.black,lineWidth: 3)
                            .frame(width: 100, height: 100)
                        
                        Eyes(value: value)
                            .stroke(Color.black,lineWidth: 3)
                            .frame(width: 100, height: 100)
                            .rotationEffect(.init(degrees: 180))
                            .offset(y : -100)
                        
                        Circle()
                            .fill(Color.black)
                            .frame(width: 20, height: 20)
                            .offset(y: -30)
                    }
                    .frame(height: 100)
                }
                    
                
            }
           
                
            
           Smile(value: value)
            .stroke(Color.black,lineWidth: 3)
            .frame(height: 100)
            
    
            GeometryReader{reder in
                
                ZStack(alignment:Alignment(horizontal: .leading, vertical: .center)){
                    
                    Color.black
                        .frame(height: 2)
                    
                    Image(systemName: "arrow.right")
                        .font(.title2)
                        .frame(width: 45, height: 45)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(20)
                        .offset(x: value * (reder.frame(in:.global).width - 45))
                        .gesture(DragGesture().onChanged({ (value) in
                            let width = reder.frame(in:.global).width - 45
                            let drag = value.location.x - 30
                            
                            if drag > 0 && drag <= width{
                            self.value = drag / width
                            }
                        }))
                        
                    
                        
                    
                    
                }
                    
                
            }
            .frame(height: 45)
            
            
            
            
            Spacer(minLength: 0)
            
            Button(action: {}) {
                Text("Done")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .background(Color.black)
                    
                    .cornerRadius(20)
                
            }
            .padding(.bottom,30)
            
            
            
        }
        .background(
            (value <= 0.3 ? Color("c1") : (value > 0.3 && value <= 0.7 ? Color("c2") : Color("c3")))
        
        )
        .ignoresSafeArea(.all, edges: .all)
        .animation(.easeOut)
    }
}

struct Smile : Shape {
    
    var value : CGFloat
    func path(in rect: CGRect) -> Path {
        
        return Path {path in
            
            let center = rect.width / 2
            
            let downRadius : CGFloat = (115 * value) - 45
            
            path.move(to: CGPoint(x: center - 150, y: 0))
            
            let to1 = CGPoint(x: center, y: downRadius)
            let cont1 = CGPoint(x: center - 145, y: 0)
            let cont2 = CGPoint(x: center - 145, y: downRadius)
            
            let to2 = CGPoint(x: center + 150, y: 0)
            let cont3 = CGPoint(x: center + 145, y: downRadius)
            let cont4 = CGPoint(x: center + 145, y: 0)
            
            path.addCurve(to: to1, control1: cont1, control2: cont2)
            path.addCurve(to: to2, control1: cont3, control2: cont4)
            
            
        }
    }
}

struct Eyes : Shape {
    
    var value : CGFloat?
    func path(in rect: CGRect) -> Path {
        
        return Path {path in
            
            let center = rect.width / 2
            
            let downRadius : CGFloat = 55 * (value ?? 1)
            
            path.move(to: CGPoint(x: center - 40, y: 0))
            
            let to1 = CGPoint(x: center, y: downRadius)
            let cont1 = CGPoint(x: center - 40, y: 0)
            let cont2 = CGPoint(x: center - 40, y: downRadius)
            
            let to2 = CGPoint(x: center + 40, y: 0)
            let cont3 = CGPoint(x: center + 40, y: downRadius)
            let cont4 = CGPoint(x: center + 40, y: 0)
            
            path.addCurve(to: to1, control1: cont1, control2: cont2)
            path.addCurve(to: to2, control1: cont3, control2: cont4)
            
            
        }
    }
}
