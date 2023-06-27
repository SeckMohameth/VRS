//
//  ExploreView.swift
//  vers-ii
//
//  Created by Mohameth Seck on 5/3/23.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        VStack {
            Group {
                Text("Top 100 In The World")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //.frame(height: 5)
                    .padding(.leading, 10)
                    .padding(.bottom, -10)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<100) {
                            Text("vid \($0)")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .frame(width: 100, height: 160)
                                .background(.green)
                                .padding(20)
                        }
                    }
                    
                }
                .scrollIndicators(.hidden)

            } // Top 100 in world
            
            
            Group {
                Text("Top 50 In NYC")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 1)
                    .padding(.leading, 10)
                    .padding(.bottom, -10)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<50) {
                            Text("vid \($0)")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .frame(width: 100, height: 160)
                                .background(.red)
                                .padding()
                        }
                    }
                    
                }
                .scrollIndicators(.hidden)
            }// top 50 in NYC
            
            Group {
                Text("Top 25 In Connecticut")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 1)
                    .padding(.leading, 10)
                    .padding(.bottom, -10)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<25) {
                            Text("vid \($0)")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .frame(width: 100, height: 160)
                                .background(.blue)
                                .padding()
                        }
                    }
                    
                }
                .scrollIndicators(.hidden)
            } //top 25 in CT
        }//End Vstack
        .frame(maxHeight: 100 )
        .padding(.bottom, 30)
    }
}


struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
