import SwiftUI
import RetailBrainSDK

struct ItemSelectionSheet: View {
    let items: [ShoppingItem]
    let onSelectionDone: ([ShoppingItem]) -> Void

    @State private var selectedItemIDs: Set<UUID> = []

    var body: some View {
        NavigationStack {
            List(items) { item in
                Button {
                    toggleSelection(for: item)
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: selectedItemIDs.contains(item.id) ? "checkmark.circle.fill" : "circle")
                            .font(.system(size: 22))
                            .foregroundColor(selectedItemIDs.contains(item.id) ? .blue : .gray)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.name)
                                .foregroundColor(.primary)

                            Text(item.storeName)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        Spacer()
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("Select Items")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        let selectedItems = items.filter { selectedItemIDs.contains($0.id) }
                        onSelectionDone(selectedItems)
                    }
                    .disabled(selectedItemIDs.isEmpty)
                }
            }
        }
        .presentationDetents([.medium, .large])
    }

    private func toggleSelection(for item: ShoppingItem) {
        if selectedItemIDs.contains(item.id) {
            selectedItemIDs.remove(item.id)
        } else {
            selectedItemIDs.insert(item.id)
        }
    }
}
