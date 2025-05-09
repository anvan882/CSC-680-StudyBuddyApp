//
//  Mainpage.swift
//  The StudyBuddy
//
//  Created by Arvin on 5/7/25.
//


import SwiftUI

struct MainScreen: View {
    var body: some View {
        VStack(spacing: 24) {

            ZStack(alignment: .bottom) {
                Color(red: 0.46, green: 0.68, blue: 0.96)
                    .ignoresSafeArea(edges: .top)

                VStack(spacing: 10) {

                    Image("planner_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .shadow(radius: 4)

                    Text("STUDY BUDDY")
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                }
                .padding(.bottom, 12)
            }
            .frame(height: 160)

            VStack(alignment: .leading, spacing: 12) {
                Text("Daily Study Goal")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))

                TextField("Enter goal", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)

            Button(action: {}) {
                Text("Start Studying")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .shadow(radius: 4)
            }
            .padding(.horizontal)

            VStack(spacing: 12) {
                HStack(spacing: 16) {
                    subjectButton("Math", color: .blue)
                    subjectButton("History", color: .orange)
                }
                HStack(spacing: 16) {
                    subjectButton("Biology", color: .purple)
                    subjectButton("English", color: .pink)
                }
                HStack {
                    subjectButton("Add new subject +", color: .gray)
                }
            }

            // QUOTE
            VStack(alignment: .leading, spacing: 12) {
                Text("Quote of the Day")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))

                TextField("...", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)

            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    func subjectButton(_ title: String, color: Color) -> some View {
        Button(action: {}) {
            Text(title)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .frame(width: 140, height: 60)
                .background(color.opacity(0.3))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                .shadow(radius: 3)
                .foregroundColor(.black)
        }
    }

    func navItem(_ systemImage: String, _ label: String) -> some View {
        VStack(spacing: 4) {
            Image(systemName: systemImage)
            Text(label)
                .font(.caption)
        }
        .foregroundColor(.black)
    }
}
