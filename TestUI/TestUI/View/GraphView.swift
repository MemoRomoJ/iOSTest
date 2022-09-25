//  GraphView.swift
//  TestUI
//  Created by Guillermo Romo Jiménez on 24/09/22.

import SwiftUI

struct GraphView: View{
    
    @State var dataModel : GraphModel?
    
    @State var yesNoPercentage = [Double]()
    @State var businessPercentage = [Double]()
    
    @State var yesNoTexts = [String]()
    @State var businessTexts = [String]()
    
    var colors = [Color.red,Color.green,Color.blue,
                        Color.orange,Color.cyan,Color.yellow]
    
    var body: some View{
        VStack{
            Text(graphStr1)
                .padding()
            
            ZStack {
                Circle()
                    .stroke(
                        Color.gray.opacity(0.5),
                        lineWidth: 20
                    )
                
                //ForEach yesNO
                ForEach(Array(yesNoPercentage.enumerated()), id: \.offset) { index, val in
                    if index == 0{
                        Circle()
                            .trim(from: 0, to: (val/100))
                            .stroke(
                                colors[index],
                                style: StrokeStyle(
                                    lineWidth: 20
                                )
                            )
                    }
                    else{
                        Circle()
                            .trim(from: (yesNoPercentage[index - 1]/100),
                                  to: (val/100))
                            .stroke(
                                colors[index],
                                style: StrokeStyle(
                                    lineWidth: 20
                                )
                            )
                    }
                    
                }
                
                // text Labels with %
            }
            .frame(width: 150, height: 150)
            .padding()
            
            Spacer()
            
            Text(graphStr2)
                .padding()
            
            ZStack {
                Circle()
                    .stroke(
                        Color.gray.opacity(0.5),
                        lineWidth: 20
                    )
                
                //ForEach business
                ForEach(Array(businessPercentage.enumerated()), id: \.offset) { index, val in
                    if index == 0{
                        Circle()
                            .trim(from: 0, to: (val/100))
                            .stroke(
                                colors[index],
                                style: StrokeStyle(
                                    lineWidth: 20
                                )
                            )
                    }
                    else{
                        Circle()
                            .trim(from: (businessPercentage[index - 1]/100),
                                  to: (val/100))
                            .stroke(
                                colors[index],
                                style: StrokeStyle(
                                    lineWidth: 20
                                )
                            )
                    }
                    
                }
                // text Labels with %
            }
            .frame(width: 150, height: 150)
            .padding()
        }
        .onAppear(){
            /// VM.getData...
            APIManager.manager.dataRequest(with: APIRoute, objectType: GraphModel.self) { (result: Result) in
                switch result {
                case .success(let object):
                    print(object)
                    self.dataModel = object
                    setDataValues()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func setDataValues(){
        for (i, d) in dataModel!.reporte.enumerated(){
            if i == 0{
                yesNoPercentage.append(Double(d.cantidad)!)
            }else{
                yesNoPercentage.append(Double(d.cantidad)! + yesNoPercentage[i - 1])
            }
        }
        
        for (i, d) in dataModel!.empresas.enumerated(){
            if i == 0{
                businessPercentage.append(Double(d.porcentaje))
            }else{
                businessPercentage.append(Double(d.porcentaje) + businessPercentage[i - 1])
            }
        }
        
        for d in dataModel!.empresas{
            businessTexts.append(d.nombre)
        }
        
        for d in dataModel!.reporte{
            yesNoTexts.append(d.valor)
        }
    }
}
