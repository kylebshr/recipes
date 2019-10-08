footer: **@kylebshr**
theme: Fira, 3
footer-style: alignment(right), text-scale(1.5)

[.hide-footer]

# Context Menus
## **From basics to polish**

^ Welcome everyone! Thank you so much for coming. First time in the office in 6 months, feels great to be back. Skiing accident, broke my back, story for another time.

^ Here to talk about context menus!

---

[.background-color: #18202a]

![inline](img/poll.png)

---

[.background-color: #18202a]

![inline](img/regret.png)

---

> ...use context menus to give people access to additional functionality related to onscreen items without cluttering the interface.

\- Human Interface Guidelines

---

[.background-color: #fafafa]
[.footer-style: color(#333)]

![inline](img/example.png)

---

# **Let’s do it!**

---

# Conform to a Protocol

```swift

extension MapViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(
    	_ interaction: UIContextMenuInteraction, 
    	configurationForMenuAtLocation location: CGPoint) 
    	-> UIContextMenuConfiguration? 
    {
    	return nil
    }
}

```

---

# Create an Interaction

```swift

let interaction = UIContextMenuInteraction(delegate: self)
view.addInteraction(interaction)

```

---

# Return a Configuration

```swift

let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in

    let favorite = UIAction(title: "Favorite", image: UIImage(systemName: "heart")) { _ in
        print("Favorite")
    }

    let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
        print("Share")
    }

    return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [favorite, share])

}

```

---

# **Catalyst**

---

[.hide-footer]
[.background-color: #fff]

![](img/original-pad.png)

^ For the most part, it really just works! 

^ But, no previews. It highlights based on the preview target.

---

```swift
private func makePhotoPreview(
	for configuration: UIContextMenuConfiguration) -> UITargetedPreview? 
{
    
    #if targetEnvironment(macCatalyst)

    return nil

    #else

    // Return normal preview...

    #endif
}
```

^ Better to just return nil

---

[.hide-footer]
[.background-color: #fff]

![](img/improved-pad.png)

^ Voila

---

# **Recap**

## Basics

---

## Add a `UIContextMenuInteraction` to your view 

### (unless it's a table or a collection)

---

## Build your menu using `UIContextMenuConfiguration`

### (and don't use index paths as identifiers!)

---

# _**Polish**_

---

## Use nested `UIMenu` objects for submenus

---

## Add custom previews with `previewProvider`

### (but maybe not on macOS)

---

## Polish your preview animation with a `UITargetedPreview`

---

## Customize your targeted preview with `UIPreviewParameters`

---

## Polish commit animations with `preferredCommitStyle`

### `animator.preferredCommitStyle = .dismiss`

^ And with that, I'll set my own animation style to dismiss - because that's all I've got for your tonight!

---

# Resources

Twitter: @kylebshr

github.com/kylebshr/recipes

kylebashour.com/posts/context-menu-guide

developer.apple.com/design/human-interface-guidelines/ios/controls/context-menus/































