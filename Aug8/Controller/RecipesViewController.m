//
//  RecipesViewController.m
//  Aug1
//
//  Created by Udo Hoppenworth on 7/31/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import "RecipesViewController.h"
#import "RecipeDetailViewController.h"
#import "DemoRecipeList.h"
#import "Recipe+Create.h"
#import "Author.h"

@implementation RecipesViewController

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"recipeName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = nil;  // all recipes
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    } else {
        self.fetchedResultsController = nil;
    }
}

#pragma mark - Initializers

// designated initializer
- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    // any additional necessary initialization goes here
    UINavigationItem *n = self.navigationItem;
    [n setTitle:@"Recipes"];
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(addNewRecipe:)];
    [self.navigationItem setRightBarButtonItem:bbi];
    
    [self.navigationItem setLeftBarButtonItem:self.editButtonItem];
}

#pragma mark - UITableView datasource and delegate methods



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Recipe"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Recipe"];
    }
    
    Recipe *r = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
    cell.textLabel.text = r.recipeName;
    cell.detailTextLabel.text = r.author.name;
    cell.imageView.image = [UIImage imageWithData:r.recipeImage];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Recipe *r = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.managedObjectContext deleteObject:r];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeDetailViewController *recipeDetailVC = [[RecipeDetailViewController alloc] init];
    Recipe *selectedRecipe = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [recipeDetailVC setRecipe:selectedRecipe];
//    [recipeDetailVC setManagedObjectContext:self.managedObjectContext];
    
    [self.navigationController pushViewController:recipeDetailVC animated:YES];
}

- (IBAction)addNewRecipe:(id)sender
{
    [Recipe recipeWithUID:[Recipe GetUUID] name:@"Default name" author:nil inContext:self.managedObjectContext];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

@end
