### Set Up Two Column Layout 

```swift
NavigationView {
    Text("Side Bar")
    Text("My List Item")
} //: NavigationView
```

### Define Manually Your CoreData Model

![image](./define_manually.png)

```swift
import Foundation
import CoreData
import AppKit

@objc(MyList)
class MyList: NSManagedObject {
    
}

extension MyList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest<MyList>(entityName: "MyList")
    }

    @NSManaged public var color: NSColor?
    @NSManaged public var name: String?

}

extension MyList : Identifiable {

}

```


### Transformermable for CoreData

1) Set Field of Your CoreData Model as Transformable

![image](./transformer.png)

2) Write Transformer 

```swift

import Foundation
import AppKit

final class NSColorTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? NSColor else { return nil }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
        } catch {
            print(error)
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSColor.self, from: data)
            return color
        } catch {
            print(error)
            return nil
        }
    }
    
}
```

3) Register Your Transformer

![image](./register.png)

4) Register it on Your Coredata stack 

```swift
import Foundation
import CoreData

final class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init() {
        
        ValueTransformer.setValueTransformer(NSColorTransformer(), forName: NSValueTransformerName("NSColorTransformer"))
        
        self.persistentContainer = NSPersistentContainer(name: "RemindersModel")
        self.persistentContainer.loadPersistentStores { desc, error in
            if let error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
}

```

### MacOS Modal

- It looks like dialogs 
- Use `sheet`

```swift
struct SideBarView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("All Items Count 10")
            
            List(1...5, id: \.self) { index in
                Text("List: \(index)")
            }
            
            Spacer()
            
            Button {
                self.isPresented.toggle()
            } label: {
                HStack {
                    Image(systemName: Constants.Icons.plusCircle)
                    Text("Add List")
                } //: HStack
            }
            .sheet(isPresented: self.$isPresented, content: {
                AddNewListView(vm: AddNewListViewModel(
                    context: self.viewContext))
            })
            .buttonStyle(.plain)
            .padding()

            
        } //: VStack
    } //: body
}
``` 
