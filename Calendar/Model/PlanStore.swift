//
//  Store.swift
//  Calendar
//
//  Created by 박정용 on 5/24/24.
//

import Foundation

final class PlanStore: ObservableObject {
    @Published var plans: [Category : [Plan]] = [:]
    @Published var detailPlans : [Category : [DetailPlan]] = [:]
    @Published var categories: [Category] = []
    private let categoriesKey = "categories"

    
    
    private let userDefaults = UserDefaults.standard
    private let plansKey = "plans"
    private let detailPlansKey = "detailPlans"
    
    init() {
        testLoadPlans()
    }
    
    
}

extension PlanStore {
    // Plans
    func savePlans() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(plans) {
            userDefaults.set(encoded, forKey: plansKey)
        }
    }
    
    func testLoadPlans() {
        if let url = Bundle.main.url(forResource: "plans", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedData = try decoder.decode(PlansData.self, from: data)
                
                var categorySet = Set<Category>()
                
                for categoryData in decodedData.plans.categories {
                    let category = Category( title: categoryData.title, color: categoryData.color)
                    let plans = categoryData.plans?.map {
                        Plan( startDate: $0.startDate, endDate: $0.endDate, title: $0.title, complete: $0.complete)
                    } ?? []
                    self.plans[category] = plans
                    categorySet.insert(category)
                }
                
                for categoryData in decodedData.detailPlans.categories {
                    let category = Category( title: categoryData.title, color: categoryData.color)
                    let detailPlans = categoryData.detailPlans?.map {
                        DetailPlan( startDate: $0.startDate, endDate: $0.endDate, title: $0.title, content: $0.content, complete: $0.complete)
                    } ?? []
                    self.detailPlans[category] = detailPlans
                    categorySet.insert(category)
                }
                self.categories = Array(categorySet)
                
            } catch {
                print("Failed to load plans: \(error)")
            }
        }
    }
    
    func loadPlans() {
            if let data = userDefaults.data(forKey: plansKey) {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([Category : [Plan]].self, from: data) {
                    self.plans = decoded
                }
            }
        }
    
    
    func addPlan(_ plan: Plan, to category: Category) {
        var categoryPlans = plans[category] ?? []
        categoryPlans.append(plan)
        plans[category] = categoryPlans
        savePlans()
    }
    
    func getPlans(for category: Category) -> [Plan] {
        return plans[category] ?? []
    }
    
    // Detail Plans
    func saveDetailPlans() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(detailPlans) {
            userDefaults.set(encoded, forKey: detailPlansKey)
        }
    }
    
    
    
    
    func addDetailPlan(_ detailPlan: DetailPlan, to category: Category) {
        var categoryDetailPlans = detailPlans[category] ?? []
        categoryDetailPlans.append(detailPlan)
        detailPlans[category] = categoryDetailPlans
        saveDetailPlans()
    }
    
    func getDetailPlans(for category: Category) -> [DetailPlan] {
        return detailPlans[category] ?? []
    }
    
    func updateDetailPlan(_ detailPlan: DetailPlan, for category: Category) {
        if var categoryDetailPlans = detailPlans[category] {
            if let index = categoryDetailPlans.firstIndex(where: { $0.id == detailPlan.id }) {
                categoryDetailPlans[index] = detailPlan
                detailPlans[category] = categoryDetailPlans
                saveDetailPlans()
            }
        }
    }
    
    func deleteDetailPlan(_ detailPlan: DetailPlan, for category: Category) {
        if var categoryDetailPlans = detailPlans[category] {
            categoryDetailPlans.removeAll(where: { $0.id == detailPlan.id })
            detailPlans[category] = categoryDetailPlans
            saveDetailPlans()
        }
    }
    
    func updatePlan(_ plan: Plan, for category: Category) {
        if var categoryPlans = plans[category] {
            if let index = categoryPlans.firstIndex(where: { $0.id == plan.id }) {
                categoryPlans[index] = plan
                plans[category] = categoryPlans
                savePlans()
            }
        }
    }
    
    func deletePlan(_ plan: Plan, for category: Category) {
        if var categoryPlans = plans[category] {
            categoryPlans.removeAll(where: { $0.id == plan.id })
            plans[category] = categoryPlans
            savePlans()
        }
    }
    
    // Categories
    func saveCategories() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(categories) {
            userDefaults.set(encoded, forKey: categoriesKey)
        }
    }

    func loadCategories() {
        if let data = userDefaults.data(forKey: categoriesKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Category].self, from: data) {
                self.categories = decoded
            }
        }
    }

    func addCategory(_ category: Category) {
        categories.append(category)
        saveCategories()
    }

    func deleteCategory(_ category: Category) {
        categories.removeAll { $0 == category }
        plans[category] = nil
        detailPlans[category] = nil
        saveCategories()
        savePlans()
        saveDetailPlans()
    }
}


struct PlansData: Codable {
    let plans: CategoriesData
    let detailPlans: CategoriesData
}

struct CategoriesData: Codable {
    let categories: [CategoryData]
}

struct CategoryData: Codable {
    let title: String
    let color: String
    let plans: [PlanData]?
    let detailPlans: [DetailPlanData]?
}


struct PlanData: Codable {
    let startDate: Date
    let endDate: Date
    let title: String
    let complete: Bool
}

struct DetailPlanData: Codable {
    let startDate: Date
    let endDate: Date
    let title: String
    let content: String
    let complete: Bool
}

extension PlanStore {
    func getAllPlans(for date: Date) -> [Category  : [AnyPlan]] {
        let calendar = Calendar.current
        var allPlans: [Category  : [AnyPlan]] = [:]
        
        for (category, plans) in plans {
                    for plan in plans {
                        if calendar.isDate(plan.startDate, inSameDayAs: date) || calendar.isDate(plan.endDate, inSameDayAs: date) {
                            if allPlans[category] == nil {
                                allPlans[category] = []
                            }
                            allPlans[category]?.append(.plan(plan))
                        }
                    }
                }
                
                for (category, detailPlans) in detailPlans {
                    for detailPlan in detailPlans {
                        if calendar.isDate(detailPlan.startDate, inSameDayAs: date) || calendar.isDate(detailPlan.endDate, inSameDayAs: date) {
                            if allPlans[category] == nil {
                                allPlans[category] = []
                            }
                            allPlans[category]?.append(.detailPlan(detailPlan))
                        }
                    }
                }
        
        return allPlans
    }
}

