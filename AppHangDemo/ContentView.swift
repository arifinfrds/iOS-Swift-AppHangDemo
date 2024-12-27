import SwiftUI

struct ContentView: View {
    @State private var isLoadingData = false
    @State private var data: [String] = []
    
    var body: some View {
        VStack {
            if isLoadingData {
                Text("Loading large data...")
                    .font(.headline)
                    .padding()
                ProgressView()
                    .scaleEffect(1.5)
            } else if !data.isEmpty {
                List(data, id: \.self) { item in
                    Text(item)
                }
            } else {
                Text("No data loaded")
                    .foregroundColor(.gray)
            }
            
            Button(action: loadData) {
                Text("Load Large Data")
                    .padding()
                    .foregroundColor(.white)
                    .background(isLoadingData ? Color.gray : Color.blue)
                    .cornerRadius(8)
            }
            .disabled(isLoadingData)
            .padding()
        }
        .padding()
    }
    
    private func loadData() {
        isLoadingData = true
        
        // Intentionally blocking the main thread to simulate a hang
        let largeData = (1...100_000).map { "Item \($0)" }
        Thread.sleep(forTimeInterval: 2) // Simulate heavy computation
        data = largeData
        
        isLoadingData = false
    }
}

#Preview {
    ContentView()
}
