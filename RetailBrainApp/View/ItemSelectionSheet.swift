import SwiftUI
import RetailBrainSDK

struct ItemSelectionSheet: View {
    let items: [ShoppingItem]
    var onSelectionDone: ([ShoppingItem]) -> Void
    @State private var selected: Set<UUID> = []

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Select Items")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Button(action: { selected.removeAll() }) {
                    Text("Clear")
                        .font(.system(size: 14))
                        .foregroundColor(.purple)
                }
            }
            .padding(16)
            
            Divider()
            
            List(items, id: \.id, selection: $selected) { item in
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.system(size: 16, weight: .semibold))
                    Text(item.storeName)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    if let description = item.description {
                        Text(description)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                .tag(item.id)
            }
            .environment(\.editMode, .constant(.active))
            
            Divider()
            
            HStack(spacing: 12) {
                Button(action: { selected.removeAll() }) {
                    Text("Cancel")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.purple)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    let selectedItems = items.filter { selected.contains($0.id) }
                    onSelectionDone(selectedItems)
                }) {
                    Text("Done")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(selected.isEmpty ? Color.gray : Color.purple)
                        .cornerRadius(8)
                }
                .disabled(selected.isEmpty)
            }
            .padding(16)
        }
        .presentationDetents([.medium, .large])
    }
}
